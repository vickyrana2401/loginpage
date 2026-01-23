
import "package:firebase_auth/firebase_auth.dart";
import "package:firebase_database/firebase_database.dart";
import "package:flutter/material.dart";
import "package:loginproduction/function/background.dart";
import "../function/apptoast.dart";


class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> {
  final _formKey =GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _dbRef = FirebaseDatabase.instance.ref();
  final TextEditingController usernameController=TextEditingController();
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  final TextEditingController confirmPasswordController=TextEditingController();
  bool isPasswordHidden=true;
  bool isLoading=false;
  bool isConfirmPassword=true;

Future <bool> registerUser() async{

    try{
      if (!_formKey.currentState!.validate()) return false;
      setState(()=> isLoading=true);
      UserCredential userCredential =
      await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final uid = userCredential.user!.uid;

      await _dbRef.child("users/$uid").update({
        "username": usernameController.text.trim(),
        "email": emailController.text.trim(),
        "online": true,
        "lastLogin": ServerValue.timestamp,
      });
      setState(() => isLoading=false );
      AppToast.show("Register Successful");
      return true;
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
      return false;

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
                controller:usernameController,
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
                      isConfirmPassword
                          ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                    ),
                    onPressed:(){
                      setState(() {
                        isConfirmPassword = !isConfirmPassword;
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
                  onPressed: isLoading ? null :() async{
                    bool success= await registerUser();
                    if (!context.mounted) return;
                    if(success){
                      Navigator.pop(context, "success");
                    }
                  },
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

