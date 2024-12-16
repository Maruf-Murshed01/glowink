import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductDetailPage extends StatefulWidget {
  final String product;
  final String image;
  final String description;
  final double price;

  ProductDetailPage(
      {required this.product,
        required this.image,
        required this.description,
        required this.price});

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;

  void _addToCart() {
    // Adding the product to the cart
    final productData = {
      'product': widget.product,
      'price': widget.price,
      'quantity': _quantity,
    };

    // Show a notification with the updated total price
    Fluttertoast.showToast(
      msg: "${widget.product} added to cart! Total: ৳${_calculateTotal()}",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );

    // You would typically add the product to a cart here, for now we're just showing the updated total
    // You can save the cart data in a state management solution or a provider.
  }

  double _calculateTotal() {
    // Calculate the total price based on quantity
    return widget.price * _quantity;
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.product)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Image.network(widget.image, height: 200),
            SizedBox(height: 20),
            Text(widget.description, style: TextStyle(fontSize: 16)),
            SizedBox(height: 20),
            Text(
              'Price: ৳${widget.price}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                IconButton(
                  onPressed: _decrementQuantity,
                  icon: Icon(Icons.remove),
                ),
                Text('$_quantity'),
                IconButton(
                  onPressed: _incrementQuantity,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addToCart,
              child: Text('Add to Cart'),
            ),
            ElevatedButton(
              onPressed: () {
                // Handle Buy Now functionality
                Navigator.pushNamed(context, '/cart');
              },
              child: Text('Buy Now'),
            ),
          ],
        ),
      ),
    );
  }
}
