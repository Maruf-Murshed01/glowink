import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // Example cart data - this would usually come from a state management solution (e.g., Provider)
  List<Map<String, dynamic>> cartItems = [];

  double _totalPrice = 0.0;

  // Method to add products to the cart
  void addToCart(String product, double price, int quantity) {
    setState(() {
      cartItems.add({
        'product': product,
        'price': price,
        'quantity': quantity,
      });
      _totalPrice += price * quantity;
    });
  }

  // Method to remove products from the cart
  void _removeFromCart(int index) {
    setState(() {
      _totalPrice -= cartItems[index]['price'] * cartItems[index]['quantity'];
      cartItems.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Shopping Cart')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                var item = cartItems[index];
                return ListTile(
                  title: Text(item['product']),
                  subtitle: Text('Quantity: ${item['quantity']}'),
                  trailing: Text('৳${item['price'] * item['quantity']}'),
                  leading: IconButton(
                    onPressed: () => _removeFromCart(index),
                    icon: Icon(Icons.remove_shopping_cart),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Total: ৳$_totalPrice',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Proceed to checkout
                // Handle checkout functionality
              },
              child: Text('Proceed to Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
