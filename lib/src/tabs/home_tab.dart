import 'package:flutter/material.dart';

class HomeTab extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;
  final ValueChanged<Map<String, dynamic>> onItemAdded;

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
        color: Colors.red
            .withOpacity(0.7), // Color rojo opaco para el fondo del cuerpo
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  addedToCart = List<bool>.generate(
                      9,
                      (index) =>
                          false); // Reiniciar los botones a su estado original
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
            Expanded(
              child: ListView.builder(
                itemCount: 9,
                itemBuilder: (context, index) {
                  return Card(
                    color:
                        Colors.blue, // Color azul para el cuadro del producto
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Image.asset(
                            'assets/product${index + 1}.jpg', // Imagen del producto
                            height: 100,
                            width: 100,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Producto ${index + 1}'),
                              Text(
                                  '\$10'), // Suponiendo que cada producto cuesta $10
                              ElevatedButton(
                                onPressed: addedToCart[index]
                                    ? null
                                    : () {
                                        setState(() {
                                          addedToCart[index] = true;
                                          widget.onItemAdded({
                                            'name': 'Producto ${index + 1}',
                                            'price': 10
                                          });
                                        });
                                      },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Colors.red, // Color rojo para el botón
                                ),
                                child: Text(
                                  addedToCart[index]
                                      ? 'Agregado'
                                      : 'Agregar al Carrito', // Texto del botón
                                  style: TextStyle(
                                    color: Colors
                                        .white, // Color blanco para el texto del botón
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
