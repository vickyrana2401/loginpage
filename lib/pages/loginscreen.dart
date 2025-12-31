import 'package:flutter/material.dart';

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
  @override
  Widget build(BuildContext context) {
    return  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [


              //Email
              TextField(
                keyboardType:TextInputType.emailAddress,
                decoration:InputDecoration(
                    labelText: "Email",
                    hintText: "User@email.com",
                    prefixIcon: const Icon(Icons.email_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    )
                ),
              ),
              const SizedBox(height: 20),
              TextField(
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
                    onPressed: isLoading ? null :(){} ,
                    child:isLoading
                    ? const CircularProgressIndicator(color: Colors.white) :
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
