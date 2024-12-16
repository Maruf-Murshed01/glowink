import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart'; // Import the cached_network_image package

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Welcome to Glowing Ink')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                // Open image in full-screen view when tapped
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ImageViewPage(
                      imageUrl:
                      'https://static.vecteezy.com/system/resources/previews/015/515/758/non_2x/bdu-letter-logo-design-on-black-background-bdu-creative-initials-letter-logo-concept-bdu-letter-design-vector.jpg',
                    ),
                  ),
                );
              },
              child: CachedNetworkImage(
                imageUrl:
                'https://static.vecteezy.com/system/resources/previews/015/515/758/non_2x/bdu-letter-logo-design-on-black-background-bdu-creative-initials-letter-logo-concept-bdu-letter-design-vector.jpg',
                imageBuilder: (context, imageProvider) => Container(
                  height: 150,
                  width: 150,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: imageProvider, fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Exclusive University Merchandise',
              style: TextStyle(fontSize: 24, color: Colors.blue[900]),
            ),
            SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/catalog');
              },
              child: Text('Browse Products'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/login');
              },
              child: Text('Login'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue[900],
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/register');
              },
              child: Text('Sign Up'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.blue[900],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ImageViewPage to view the image in full screen
class ImageViewPage extends StatelessWidget {
  final String imageUrl;

  ImageViewPage({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('University Logo')),
      body: Center(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          placeholder: (context, url) => CircularProgressIndicator(),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
      ),
    );
  }
}
