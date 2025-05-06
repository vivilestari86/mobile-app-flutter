import 'package:flutter/material.dart';
class ManajemenPostPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen Post'),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman Manajemen Post',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
