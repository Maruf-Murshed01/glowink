import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/cart_item.dart';

class FirestoreService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveOrder({
    required List<CartItem> items,
    required String transactionId,
    required double totalAmount,
  }) async {
    try {
      // Create order data
      final orderData = {
        'transactionId': transactionId,
        'totalAmount': totalAmount,
        'orderDate': FieldValue.serverTimestamp(),
        'items': items
            .map((item) => {
                  'productId': item.product.id,
                  'productName': item.product.name,
                  'quantity': item.quantity,
                  'price': item.product.price,
                  'totalPrice': item.totalPrice,
                })
            .toList(),
        'status': 'completed',
      };

      // Save to orders collection
      await _firestore.collection('orders').add(orderData);
    } catch (e) {
      print('Error saving order: $e');
      rethrow;
    }
  }
}
