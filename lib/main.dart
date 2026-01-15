import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginproduction/function/appbackground.dart';
import 'package:loginproduction/function/loginscreen.dart';
import 'package:loginproduction/function/header.dart';
import 'package:firebase_messaging/firebase_messaging.dart';


Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background message: ${message.messageId}");
}
void main()  async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(
    firebaseMessagingBackgroundHandler,
  );
  FirebaseMessaging.onBackgroundMessage(
    _firebaseBackgroundHandler,
  );
  runApp(const MyApp());
}

@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(
    RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Background message: ${message.messageId}");
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
 