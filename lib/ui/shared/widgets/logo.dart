import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.bubble_chart_outlined, color: Colors.blueAccent),
          SizedBox(
            width: 10,
          ),
          Text('Admin',
              style: GoogleFonts.montserratAlternates(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.w200)),
        ],
      ),
    );
  }
}
