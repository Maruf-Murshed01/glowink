import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'models/cart_item.dart';
import 'models/product.dart';

class ProductDetailPage extends StatefulWidget {
  final String product;
  final String image;
  final String description;
  final double price;

  ProductDetailPage({
    required this.product,
    required this.image,
    required this.description,
    required this.price,
  });

  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  int _quantity = 1;
  double _totalPrice = 0.0;

  @override
  void initState() {
    super.initState();
    _totalPrice = widget.price;
  }

  void _addToCart() {
    // Create a Product object
    final product = Product(
      id: DateTime.now().toString(), // temporary ID
      name: widget.product,
      description: widget.description,
      price: widget.price,
      imageUrl: widget.image,
      category: 'General', // You might want to add category to the widget
      stockQuantity: 100, // You might want to manage stock properly
    );

    // Check if product already exists in cart
    final existingCartItemIndex = cartItems.indexWhere(
      (item) => item.product.name == product.name,
    );

    if (existingCartItemIndex != -1) {
      // Update quantity if product exists
      setState(() {
        cartItems[existingCartItemIndex].quantity += _quantity;
      });
    } else {
      // Add new cart item if product doesn't exist
      cartItems.add(CartItem(
        product: product,
        quantity: _quantity,
      ));
    }

    Fluttertoast.showToast(
      msg: "${widget.product} added to cart! Total: ৳$_totalPrice",
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
    );
  }

  void _incrementQuantity() {
    setState(() {
      _quantity++;
      _totalPrice = widget.price * _quantity;
    });
  }

  void _decrementQuantity() {
    if (_quantity > 1) {
      setState(() {
        _quantity--;
        _totalPrice = widget.price * _quantity;
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
            SizedBox(height: 10),
            Text(
              'Total: ৳$_totalPrice',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _decrementQuantity,
                  icon: Icon(Icons.remove_circle_outline),
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).primaryColor),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '$_quantity',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                IconButton(
                  onPressed: _incrementQuantity,
                  icon: Icon(Icons.add_circle_outline),
                  color: Theme.of(context).primaryColor,
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton.icon(
                  onPressed: _addToCart,
                  icon: Icon(Icons.shopping_cart),
                  label: Text('Add to Cart'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  ),
                ),
                ElevatedButton.icon(
                  onPressed: () {
                    _addToCart();
                    Navigator.pushNamed(context, '/cart');
                  },
                  icon: Icon(Icons.flash_on),
                  label: Text('Buy Now'),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    backgroundColor: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
