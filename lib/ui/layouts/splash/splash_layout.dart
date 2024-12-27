import 'package:flutter/material.dart';

class SplashLayout extends StatelessWidget {
  const SplashLayout({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              color: Colors.red,
            ),
            SizedBox(height: 10),
            Text(
              'Please wait...',
              style: TextStyle(color: Colors.red),
            ),
          ],
        ),
      ),
    );
  }
}
