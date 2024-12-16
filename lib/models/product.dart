class Product {
  final String id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final String category;
  final int stockQuantity;

  const Product({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.category,
    required this.stockQuantity,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String,
      stockQuantity: json['stockQuantity'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'category': category,
      'stockQuantity': stockQuantity,
    };
  }
}

// Dummy data for testing
final List<Product> dummyProducts = [
  Product(
    id: '1',
    name: 'University T-Shirt',
    description: 'Comfortable cotton t-shirt with university logo',
    price: 19.99,
    imageUrl: 'https://example.com/tshirt.jpg',
    category: 'Clothing',
    stockQuantity: 100,
  ),
  // Add more dummy products...
];
