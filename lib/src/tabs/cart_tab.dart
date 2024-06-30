import 'package:flutter/material.dart';

class CartTab extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  CartTab({required this.cartItems});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartTab> {
  late List<int> quantities; // Usamos late para inicializar en didUpdateWidget

  @override
  void initState() {
    super.initState();
    quantities = List<int>.generate(widget.cartItems.length, (index) => 1);
  }

  @override
  void didUpdateWidget(covariant CartTab oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.cartItems.length != quantities.length) {
      quantities = List<int>.generate(widget.cartItems.length, (index) => 1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Carrito de Compras'),
      ),
      body: Column(
        children: [
          Expanded(
            child: widget.cartItems.isEmpty
                ? Center(
                    child: Text('El carrito está vacío'),
                  )
                : ListView.builder(
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(widget.cartItems[index]['name']),
                        subtitle: Text('\$${widget.cartItems[index]['price']}'),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              icon: Icon(Icons.remove),
                              onPressed: () {
                                setState(() {
                                  if (quantities[index] > 1) {
                                    quantities[index]--;
                                  }
                                });
                              },
                            ),
                            Text(quantities[index].toString()),
                            IconButton(
                              icon: Icon(Icons.add),
                              onPressed: () {
                                setState(() {
                                  quantities[index]++;
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Total: \$${widget.cartItems.asMap().entries.fold(0, (total, entry) => total + (entry.value['price'] * quantities[entry.key]) as int)}', // Calculo del total
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }
}
