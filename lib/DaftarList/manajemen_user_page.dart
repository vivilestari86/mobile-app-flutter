import 'package:flutter/material.dart';
class ManajemenUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manajemen User'),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman Manajemen User',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
