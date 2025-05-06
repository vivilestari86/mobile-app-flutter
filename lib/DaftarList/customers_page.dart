import 'package:flutter/material.dart';
class CustomersPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Customers'),
      ),
      body: Center(
        child: Text(
          'Ini adalah halaman Customers',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
