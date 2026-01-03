import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginproduction/function/AppBackground.dart';
import 'package:loginproduction/function/LoginScreen.dart';
import 'package:loginproduction/function/header.dart';



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
     );
   }
 }
 