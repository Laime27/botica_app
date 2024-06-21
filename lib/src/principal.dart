import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopin E-commerce',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: ECommercePage(),
    );
  }
}

class ECommercePage extends StatefulWidget {
  @override
  _ECommercePageState createState() => _ECommercePageState();
}

class _ECommercePageState extends State<ECommercePage> {
  int _selectedIndex = 0;
  final PageController _pageController = PageController();

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<String> cartItems = []; // Lista de productos en el carrito

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Image.asset(
          'assets/logo.jpg',
          height: 200, // Ajusta el tamaño del logo según sea necesario
        ),
        backgroundColor: Colors.white,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          HomeTab(cartItems: cartItems, onItemAdded: (item) {
            setState(() {
              cartItems.add(item);
            });
          }), // Página de Compras
          CartTab(cartItems: cartItems), // Carrito
          FeedTab(), // Feed
          MessagesTab(), // Mensajes
          UserTab(), // Usuario
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Cart'),
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

// HomeTab: Página de Compras
class HomeTab extends StatefulWidget {
  final List<String> cartItems;
  final ValueChanged<String> onItemAdded;

  HomeTab({required this.cartItems, required this.onItemAdded});

  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  List<bool> addedToCart = List<bool>.generate(9, (index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red.withOpacity(0.7), // Color rojo opaco para el fondo del cuerpo
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Card(
                    color: Colors.blue, // Color azul para el cuadro del producto
                    elevation: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/product${index + 1}.jpg', // Imagen del producto
                          height: 350, // Ajusta el tamaño de la imagen según sea necesario
                          fit: BoxFit.cover,
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: addedToCart[index]
                              ? null
                              : () {
                            setState(() {
                              addedToCart[index] = true;
                              widget.onItemAdded('product ${index + 1}');
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red, // Color rojo para el botón
                          ),
                          child: Text(
                            addedToCart[index] ? 'Agregado' : 'Agregar al Carrito', // Texto del botón
                            style: TextStyle(
                              color: Colors.white, // Color blanco para el texto del botón
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  addedToCart = List<bool>.generate(9, (index) => false); // Reiniciar los botones a su estado original
                  widget.cartItems.clear();
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Color rojo para el botón
              ),
              child: Text(
                'Descartar Compra',
                style: TextStyle(
                  color: Colors.white, // Color blanco para el texto del botón
                ),
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

// CartTab: Carrito
class CartTab extends StatelessWidget {
  final List<String> cartItems;

  CartTab({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return CartPage(cartItems: cartItems);
  }
}

// CartPage: Página del carrito de compras
class CartPage extends StatelessWidget {
  final List<String> cartItems;

  CartPage({required this.cartItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: cartItems.isEmpty
          ? Center(
        child: Text('El carrito está vacío'),
      )
          : ListView.builder(
        itemCount: cartItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(cartItems[index]),
          );
        },
      ),
    );
  }
}

// FeedTab: Feed
class FeedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Feed'),
      ),
    );
  }
}

// MessagesTab: Mensajes
class MessagesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Messages'),
      ),
    );
  }
}

// UserTab: Usuario
class UserTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('User'),
      ),
    );
  }
}
