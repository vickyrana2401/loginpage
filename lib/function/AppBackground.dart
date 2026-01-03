import 'package:flutter/material.dart';

class AppBackground extends StatelessWidget {
  final Widget child;
  const AppBackground({super.key,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFF0F2027),
            Color(0xFF203A42),
            Color(0xFF2C5364),
          ],
        ),
      ),
      child:SafeArea(
    child: Stack(
    children:[
      Positioned(
        bottom: -80,
        left: -60,
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.08),
            shape:BoxShape.circle,
          ),
        ),
      ),
      Positioned(
        top: -80,
        right:-60,
        child: Container(
          width: 180,
          height: 180,
          decoration: BoxDecoration(
            color:Colors.white.withValues(alpha:0.08),
            shape: BoxShape.circle,
          ),
        ),
      ),
    Center(
        child:SingleChildScrollView(
            padding:const EdgeInsets.all(24),
            child:Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                  color:Colors.white,
                  borderRadius : BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withValues(alpha:0.2),
                        blurRadius: 20,
                        offset: const Offset(0,10)
                    )
                  ]
              ),
              child:child,
            )
        )
    )])
      )
    );
  }
}