import "package:flutter/material.dart";
import "package:loginproduction/function/AppBackground.dart";

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  State<RegisterPage> createState() => _RegisterPageState();
}



class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController=TextEditingController();
  final TextEditingController passwordController=TextEditingController();
  bool isPasswordHidden=true;
  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: Column(
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
                controller:null,
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
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText:"Email" ,
                  prefixIcon: const Icon(Icons.email_rounded),
                  border: OutlineInputBorder(
                    borderRadius:BorderRadius.circular(12),
                  ),
                ),
              ),
              const SizedBox(height:20),
              TextField(
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
              ),
              const SizedBox(height:20),
              TextField(
                obscureText: isPasswordHidden,
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
              ),
              const SizedBox(height:20),
              TextButton(onPressed:(){}, child: Text("Continue"))
            ]
        ),
      )
    );
  }
}

