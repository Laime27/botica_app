import 'package:flutter/material.dart';
import 'tabs/home_tab.dart';
import 'tabs/cart_tab.dart';
import 'tabs/feed_tab.dart';
import 'tabs/messages_tab.dart';
import 'tabs/user_tab.dart';

class Principal extends StatefulWidget {
  @override
  _PrincipalState createState() => _PrincipalState();
}

class _PrincipalState extends State<Principal> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Map<String, dynamic>> cartItems =
      []; // Lista de productos en el carrito

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.jpg',
          height: 50,
        ),
        backgroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeTab(
            cartItems: cartItems,
            onItemAdded: (item) {
              setState(() {
                cartItems.add(item);
              });
            },
          ),
          CartTab(cartItems: cartItems), // Carrito
          FeedTab(), // Feed
          MessagesTab(), // Mensajes
          UserTab(), // Usuario
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Store'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'Cart'),
          BottomNavigationBarItem(icon: Icon(Icons.feed), label: 'Feed'),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Messages'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'User'),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.purple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),
    );
  }
}
