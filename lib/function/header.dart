import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return
    Center(
    child:Column(
      children: [
        Icon(Icons.lock_outline,
            size: 72,
            color:Colors.black
        ),
        SizedBox(height: 16),
        Text(
          "Welcome Back",
          style:TextStyle(
            fontSize: 26,
            color:Colors.grey,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Text(
          "Sign in to continue",
          style: TextStyle(
              color: Colors.grey
          ),
        ),
      ],
    ),
    );

  }
}
