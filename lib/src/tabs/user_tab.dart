import 'package:flutter/material.dart';

class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person, size: 100, color: Colors.grey),
            SizedBox(height: 20),
            Text('Nombre de Usuario', style: TextStyle(fontSize: 24)),
            SizedBox(height: 10),
            Text('correo@ejemplo.com', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
