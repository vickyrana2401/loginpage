import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:loginproduction/Pages/forgotpage.dart';
import 'package:loginproduction/Pages/login-successful.dart';
import 'package:loginproduction/Pages/register.dart';
import 'package:loginproduction/Pages/login-screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> _firebaseBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint("Background message: ${message.messageId}");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundHandler);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/register': (context) => RegisterPage(),
        '/logins':(context) => LoginSuccessful(),
        '/forgot':(context) => ForgotPasswordScreen()
      },
    );
  }
}
