import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginproduction/Pages/LoginSuccessful.dart';
import 'package:loginproduction/Pages/RegisterPage.dart';

import 'AppToast.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  bool isPasswordHidden=true;
  bool isLoading=false;

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  Future<bool> login() async{
    try{
      await
    FirebaseAuth.instance.signInWithEmailAndPassword(
      email:emailController.text.trim(),
      password: passwordController.text.trim()
    );
      AppToast.show("Login Successful");
      return true;
    }
    catch(e){
      if(e is FirebaseAuthException) {
        AppToast.show(e.message ?? "Login faild");
        return false;
      }
      else{
        AppToast.show("Something went wrong");
        return false;
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Email
              TextField(
                controller: emailController,
                keyboardType:TextInputType.emailAddress,
                decoration:InputDecoration(
                    labelText: "Email",
                    hintText: "user@email.com",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText:isPasswordHidden,
                decoration:InputDecoration(
                    labelText: "Password",
                    prefixIcon: const Icon(Icons.lock_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                          isPasswordHidden
                          ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                      ),
                      onPressed:(){
                        setState(() {
                          isPasswordHidden = !isPasswordHidden;
                        });
                      },
                    )
                ),
              ),
              const SizedBox(height: 30),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                    onPressed: isLoading ? null :() async {
                      bool success= await login();
                      if (!context.mounted) return;
                      if( success){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> LoginSuccessful())
                        );
                      }

                    } ,
                    child:isLoading
                    ? const CircularProgressIndicator(
                      color: Colors.blue,
                      strokeWidth: 4,) :
                        const Text(
                          "Login",
                          style: TextStyle(fontSize: 16),
                        )
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don’t have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context)=> RegisterPage())
                      );

                    },
                    child: const Text("Register"),
                  ),
                ],
              ),
              /// Footer
              Text(
                "© 2025 LoginPractice",
                style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
              ),
            ],

    );
  }
}
