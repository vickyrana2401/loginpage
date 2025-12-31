import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginproduction/function/AppBackground.dart';
import 'package:loginproduction/function/LoginScreen.dart';
import 'package:loginproduction/function/header.dart';
import 'firebase_options.dart';


void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
       debugShowCheckedModeBanner:false,
         home:Scaffold(
       backgroundColor: Colors.white,
       body:AppBackground(
       child:SafeArea(
         child: Stack(
           children: [

           // Decorative circle
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
                       color: Colors.black.withValues(alpha:0.2),
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

       ])
       )
       )
         )
     );
   }
 }
 