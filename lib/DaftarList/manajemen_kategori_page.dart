import 'package:flutter/material.dart';
class ManajemenKategoriPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Kategori'),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman Manajemen Kategori',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
