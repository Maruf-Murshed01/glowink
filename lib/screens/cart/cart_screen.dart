import 'package:flutter/material.dart';
import '../../models/cart_item.dart';
import '../../services/firestore_service.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _formKey = GlobalKey<FormState>();
  final _transactionController = TextEditingController();
  final _firestoreService = FirestoreService();
  bool _isProcessing = false;

  double get _totalPrice {
    return cartItems.fold(
      0,
      (sum, item) => sum + (item.product.price * item.quantity),
    );
  }

  void _updateQuantity(int index, int newQuantity) {
    if (newQuantity >= 1) {
      setState(() {
        cartItems[index].quantity = newQuantity;
      });
    }
  }

  void _removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void _showCheckoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Complete Purchase'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Total Amount: ৳${_totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _transactionController,
                  decoration: const InputDecoration(
                    labelText: 'Transaction ID',
                    border: OutlineInputBorder(),
                    hintText: 'Enter your transaction ID',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter transaction ID';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: _isProcessing ? null : _processCheckout,
              child: _isProcessing
                  ? const SizedBox(
                      height: 20,
                      width: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Text('Confirm Purchase'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _processCheckout() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isProcessing = true);
      try {
        await _firestoreService.saveOrder(
          items: cartItems,
          transactionId: _transactionController.text,
          totalAmount: _totalPrice,
        );

        if (!mounted) return;
        Navigator.pop(context); // Close the dialog
        _showSuccessDialog();
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: Colors.red,
          ),
        );
      } finally {
        if (mounted) {
          setState(() => _isProcessing = false);
        }
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 60,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Thank you for your purchase!',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Transaction ID: ${_transactionController.text}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  cartItems.clear();
                });
                _transactionController.clear();
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    _transactionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          if (cartItems.isNotEmpty)
            IconButton(
              icon: const Icon(Icons.remove_shopping_cart),
              onPressed: () => setState(() => cartItems.clear()),
              tooltip: 'Clear Cart',
            ),
        ],
      ),
      body: cartItems.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined,
                      size: 100, color: Colors.grey),
                  const SizedBox(height: 20),
                  const Text(
                    'Your cart is empty',
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => Navigator.pushNamed(context, '/catalog'),
                    child: const Text('Go to Catalog'),
                  ),
                ],
              ),
            )
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      final item = cartItems[index];
                      return CartItemTile(
                        cartItem: item,
                        onQuantityChanged: (quantity) =>
                            _updateQuantity(index, quantity),
                        onRemove: () => _removeItem(index),
                      );
                    },
                  ),
                ),
                CartSummary(
                  subtotal: _totalPrice,
                  onCheckout: _showCheckoutDialog,
                ),
              ],
            ),
    );
  }
}

class CartItemTile extends StatelessWidget {
  final CartItem cartItem;
  final Function(int) onQuantityChanged;
  final VoidCallback onRemove;

  const CartItemTile({
    Key? key,
    required this.cartItem,
    required this.onQuantityChanged,
    required this.onRemove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(
        cartItem.product.imageUrl,
        width: 50,
        height: 50,
        fit: BoxFit.cover,
      ),
      title: Text(cartItem.product.name),
      subtitle: Text('৳${cartItem.product.price}'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.remove),
            onPressed: () => onQuantityChanged(cartItem.quantity - 1),
          ),
          Text('${cartItem.quantity}'),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => onQuantityChanged(cartItem.quantity + 1),
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: onRemove,
          ),
        ],
      ),
    );
  }
}

class CartSummary extends StatelessWidget {
  final double subtotal;
  final VoidCallback onCheckout;

  const CartSummary({
    Key? key,
    required this.subtotal,
    required this.onCheckout,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Subtotal:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '৳${subtotal.toStringAsFixed(2)}',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onCheckout,
              child: const Text('Proceed to Checkout'),
            ),
          ),
        ],
      ),
    );
  }
}
