import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Entry Point
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'CRUD App',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: LoginPage(),
    );
  }
}

// Login Page
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  void _login() {
    if (_usernameController.text == 'admin@gmail.com' &&
        _passwordController.text == 'admin12345') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Username atau password salah')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.blueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock, size: 80, color: Colors.blue),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _usernameController,
                      label: 'Username',
                    ),
                    SizedBox(height: 16),
                    _buildTextField(
                      controller: _passwordController,
                      label: 'Password',
                      obscureText: true,
                    ),
                    SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _login,
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 24,
                        ),
                      ),
                      child: Text('Login', style: TextStyle(fontSize: 18)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    bool obscureText = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}

// Home Page
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Map<String, dynamic>> _items = [
    {'title': 'Dashboard', 'page': DashboardPage()},
    {'title': 'Manajemen User', 'page': ManajemenUserPage()},
    {'title': 'Manajemen Kategori', 'page': ManajemenKategoriPage()},
    {'title': 'Manajemen Post', 'page': ManajemenPostPage()},
    {'title': 'Customers', 'page': CustomersPage()},
  ];

void _addItem(BuildContext context) {
  _showItemDialog(context, title: 'Tambah Item', onSave: (title) {
    setState(() {
      _items.add({
        'title': title,
        'page': ItemPage(title: title, initialContent: 'Konten untuk $title'),
      });
    });

    // Tampilkan SnackBar setelah item ditambahkan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Item "$title" berhasil ditambahkan!')),
    );
  });
}

void _editItem(int index, BuildContext context) {
  _showItemDialog(
    context,
    title: 'Edit Item',
    initialText: _items[index]['title'],
    onSave: (title) {
      setState(() {
        _items[index]['title'] = title;
        _items[index]['page'] =
            ItemPage(title: title, initialContent: 'Konten diperbarui untuk $title');
      });

      // Tampilkan SnackBar setelah item diedit
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Item "${_items[index]['title']}" berhasil diperbarui!')),
      );
    },
  );
}

void _deleteItem(int index, BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text('Hapus Item'),
      content: Text('Apakah Anda yakin ingin menghapus item ini?'),
      actions: [
        TextButton(
          onPressed: () {
            setState(() {
              _items.removeAt(index);
            });
            Navigator.pop(context);

            // Tampilkan SnackBar setelah item dihapus
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Item berhasil dihapus!')),
            );
          },
          child: Text('Hapus'),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beranda'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) => _buildListItem(context, index),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _addItem(context),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _buildListItem(BuildContext context, int index) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(_items[index]['title'][0]),
        ),
        title: Text(_items[index]['title']),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => _items[index]['page']),
          );
        },
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Colors.blue),
              onPressed: () => _editItem(index, context),
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Colors.red),
              onPressed: () => _deleteItem(index, context),
            ),
          ],
        ),
      ),
    );
  }

  void _showItemDialog(BuildContext context,
      {required String title,
      String? initialText,
      required Function(String) onSave}) {
    final _controller = TextEditingController(text: initialText);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: TextField(
          controller: _controller,
          decoration: InputDecoration(hintText: 'Nama item'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_controller.text.isNotEmpty) {
                onSave(_controller.text);
                Navigator.pop(context);
              }
            },
            child: Text('Simpan'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Batal'),
          ),
        ],
      ),
    );
  }
}

// Pages
class ItemPage extends StatefulWidget {
  final String title;
  final String initialContent;

  ItemPage({required this.title, required this.initialContent});

  @override
  _ItemPageState createState() => _ItemPageState();
}

class _ItemPageState extends State<ItemPage> {
  late TextEditingController _textController;

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.initialContent);
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _saveContent() {
    // Simpan teks ke state atau backend jika diperlukan
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Teks berhasil disimpan!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _textController,
              maxLines: null,
              decoration: InputDecoration(
                labelText: 'Tulis sesuatu',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _saveContent,
              child: Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }
}

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ItemPage(
      title: 'Dashboard',
      initialContent: 'Selamat datang di halaman Dashboard!',
    );
  }
}

class ManajemenUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ItemPage(
      title: 'Manajemen User',
      initialContent: 'Ini adalah halaman Manajemen User.',
    );
  }
}

class ManajemenKategoriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ItemPage(
      title: 'Manajemen Kategori',
      initialContent: 'Ini adalah halaman Manajemen Kategori.',
    );
  }
}

class ManajemenPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ItemPage(
      title: 'Manajemen Post',
      initialContent: 'Ini adalah halaman Manajemen Post.',
    );
  }
}

class CustomersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ItemPage(
      title: 'Customers',
      initialContent: 'Ini adalah halaman Customers.',
    );
  }
}
