import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";
import "package:loginproduction/function/AppBackground.dart";

import "../function/AppToast.dart";


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> {
  final _formKey =GlobalKey<FormState>();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();
  bool isPasswordHidden=true;
  bool isLoading=false;
  bool isConfirmPassword=true;

  Future <void> registerUser() async{

    try{
      if (!_formKey.currentState!.validate()) return;
      setState(()=> isLoading=true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email:emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      setState(() => isLoading=false );
      AppToast.show("Register Successful");
    }
    on FirebaseAuthException catch (e){
      setState(()=> isLoading= false);

      String message = "Registration failed";
      if (e.code =='email-already-in-use'){
        message = "Email already  register";
      }else if(e.code == 'weak-password'){
        message ="Password too weak";
      }else if(e.code =='invalid-email'){
        message = "invalid email address";
      }
      AppToast.show(message);

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Form(
          key: _formKey,
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height:120,
                width:120,
                decoration: BoxDecoration(
                  color:Colors.black45.withValues(alpha:0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_rounded,
                  color:Colors.blueGrey,
                  size:80,
                ),
              ),
              SizedBox(height: 12),
              TextField(
                keyboardType:TextInputType.text,
                decoration: InputDecoration(
                    labelText:"User Name",
                    hintText: " Username",
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius:BorderRadius.circular(12),
                    )
                ),
              ),
              const SizedBox(height:20),
              TextFormField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText:"Email" ,
                  prefixIcon: const Icon(Icons.email_rounded),
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(12),
                  ),
                ),
                validator: (value) => value!.contains("@") ? null : "Enter valid email",
              ),
              const SizedBox(height:20),
              TextFormField(
                controller: passwordController,
                obscureText:isPasswordHidden,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: "Password",
                  prefixIcon: const Icon(Icons.lock_outline),
                  border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  suffixIcon:IconButton(
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
                validator: (value) => value!.length < 6 ? "Min 6 characters" : null,
              ),
              const SizedBox(height:20),
              TextFormField(
                controller: confirmPasswordController,
                obscureText: isConfirmPassword,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText:"Confirm Password",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12) ,
                  ),
                  suffixIcon:IconButton(
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
                validator:(value) =>
                    value != passwordController.text
                  ? "Password do not match" : null,
              ),
              const SizedBox(height:20),
              TextButton(
                  onPressed: isLoading ? null : registerUser,
                  child: isLoading ?
                      const SizedBox(
                        width: 22,
                        height: 22,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                      : const Text("Register"),
              )
            ]
        ),)
      )
    );
  }
}

