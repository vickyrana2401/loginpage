import "package:flutter/material.dart";
import "package:loginproduction/function/AppBackground.dart";

class Registerpage extends StatelessWidget {
  const Registerpage.RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child:SafeArea(
          child: Stack(
            children:[
              Positioned(
                bottom: -80,
                left: -60,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.08),
                    shape:BoxShape.circle,
                  ),
                ),
              ),
              Positioned(
                top: -80,
                right:-60,
                child: Container(
                  width: 180,
                  height: 180,
                  decoration: BoxDecoration(
                    color:Colors.white.withValues(alpha:0.08),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              Center(
                child:SingleChildScrollView(
                  padding:const EdgeInsets.all(24),
                  child:Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color:Colors.white,
                      borderRadius : BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha:0.2),
                          blurRadius: 20,
                          offset: const Offset(0,10)
                        )
                      ]
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                        children: [
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
                )
              )
            ]
          ),
        ),
      ),
    );
  }
}

