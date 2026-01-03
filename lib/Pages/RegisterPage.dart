import "package:flutter/material.dart";
import "package:loginproduction/function/AppBackground.dart";

class Registerpage extends StatelessWidget {
  const Registerpage.RegisterPage({super.key});

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
                            obscureText:true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText: "Password",
                              prefixIcon: const Icon(Icons.lock_outline),
                              border:OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)
                              ),
                              suffixIcon:IconButton(
                                icon:Icon(Icons.visibility_outlined),
                                onPressed: (){},
                              ),
                            ),
                          ),
                          const SizedBox(height:20),
                          TextField(
                            obscureText: true,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              labelText:"Confirm Password",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12) ,
                              ),
                              suffixIcon:IconButton(
                            icon:Icon(Icons.visibility_outlined),
                            onPressed: (){},
                          ),
                            ),


                          ),
                          const SizedBox(height:20),
                          TextButton(onPressed:(){}, child: Text("Continue"))


                    ]),
                  )
    );
  }
}

