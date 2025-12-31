import 'package:flutter/material.dart';
import 'package:loginproduction/pages/appbackground.dart';
import 'package:loginproduction/pages/loginscreen.dart';
import 'package:loginproduction/pages/header.dart';

void main() {
  runApp(const MyApp());
}
 class MyApp extends StatefulWidget {
   const MyApp({super.key});
 
   @override
   State<MyApp> createState() => _MyAppState();
 }

 class _MyAppState extends State<MyApp> {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
         home:Scaffold(
       backgroundColor: Colors.white,
       body:AppBackground(
       child:SafeArea(
         child: Stack(
           children: [

           // Decorative circle
           Positioned(
           top: -80,
           right: -60,
           child: Container(
             width: 180,
             height: 180,
             decoration: BoxDecoration(
               color: Colors.white.withValues(alpha: 0.08),
               shape: BoxShape.circle,
             ),
           ),
         ),
           Center(
         child:SingleChildScrollView(
             padding: const EdgeInsets.all(24),
             child: Container(
                 padding: const EdgeInsets.all(24),
                 decoration: BoxDecoration(
                   color: Colors.white,
                   borderRadius: BorderRadius.circular(20),
                   boxShadow: [
                     BoxShadow(
                       color: Colors.black.withOpacity(0.2),
                       blurRadius: 20,
                       offset: const Offset(0, 10),
                     ),
                   ],
                 ),


           child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
             children: const [

               SizedBox(height: 40),
                Header(),
               SizedBox(height: 40),
               LoginScreen(),
             ]
           )
         )

                )
         ),
             Positioned(
               bottom: -80,
               left: -60,
               child: Container(
                 width: 180,
                 height: 180,
                 decoration: BoxDecoration(
                   color: Colors.white.withValues(alpha: 0.08),
                   shape: BoxShape.circle,
                 ),
               ),
             ),
       ])
       )
       )
         )
     );
   }
 }
 