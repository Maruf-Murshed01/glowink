import 'package:flutter/material.dart';

class AdminPanelPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                // Navigate to product management
              },
              child: Text('Manage Products'),
            ),
            ElevatedButton(
              onPressed: () {
                // Navigate to view sales data
              },
              child: Text('View Sales Reports'),
            ),
            ElevatedButton(
              onPressed: () {
                // Log out
              },
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
