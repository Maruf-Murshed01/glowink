import 'package:flutter/material.dart';
import 'product_detail.dart';

class CatalogPage extends StatelessWidget {
  final List<String> categories = [
    'Art Supplies',
    'Electronics & Tech',
    'Medicine & Health',
    'Textbooks & Course Materials',
    'Event Tickets',
    'Sensor Projects (IoT)',
  ];

  final Map<String, List<Map<String, dynamic>>> categoryProducts = {
    'Art Supplies': [
      {
        'name': 'Watercolor Set',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 1500,
        'description': 'High-quality watercolor set for artists.'
      },
      {
        'name': 'Acrylic Paint Set',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 2000,
        'description': 'A complete acrylic paint set for all levels of artists.'
      },
    ],
    'Electronics & Tech': [
      {
        'name': 'Laptop',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 40000,
        'description': 'High-performance laptop for university students.'
      },
      {
        'name': 'Smartphone',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 25000,
        'description':
        'Smartphone with the latest features and high battery life.'
      },
    ],
    'Medicine & Health': [
      {
        'name': 'First Aid Kit',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 1000,
        'description': 'Complete first aid kit for emergencies.'
      },
      {
        'name': 'Vitamins',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 800,
        'description': 'Multivitamin supplements for daily health.'
      },
    ],
    'Textbooks & Course Materials': [
      {
        'name': 'Introduction to Programming',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 1200,
        'description': 'A textbook for programming basics and foundations.'
      },
      {
        'name': 'Data Structures',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 1500,
        'description':
        'Detailed guide on various data structures used in computer science.'
      },
    ],
    'Event Tickets': [
      {
        'name': 'Tech Fest Ticket',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 500,
        'description': 'Ticket for the annual university tech fest.'
      },
      {
        'name': 'University Play Ticket',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 300,
        'description': 'Tickets for the upcoming university play.'
      },
    ],
    'Sensor Projects (IoT)': [
      {
        'name': 'Arduino Kit',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 3500,
        'description': 'Complete Arduino kit for beginners.'
      },
      {
        'name': 'Raspberry Pi Kit',
        'image':
        'https://cdn.shopify.com/s/files/1/0088/0056/7392/files/fgh_large.jpg?v=1593632759',
        'price': 4500,
        'description':
        'A powerful Raspberry Pi kit to start building IoT projects.'
      },
    ],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Catalog')),
      body: ListView.builder(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          String category = categories[index];
          List<Map<String, dynamic>> products = categoryProducts[category]!;

          return Card(
            elevation: 5,
            child: ExpansionTile(
              title: Text(category,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              children: [
                GridView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, productIndex) {
                    var product = products[productIndex];
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(
                              product: product['name']!,
                              image: product['image']!,
                              description: product['description']!,
                              price: product['price'],
                            ),
                          ),
                        );
                      },
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Image.network(
                              product['image']!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                            Text(product['name']!,
                                style: TextStyle(fontSize: 14)),
                            Text('৳${product['price']}',
                                style: TextStyle(
                                    fontSize: 14, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
