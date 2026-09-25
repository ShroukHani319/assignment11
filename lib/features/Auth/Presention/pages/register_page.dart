import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Sign Up")),
        backgroundColor: Color(0xFF1A237E),
        foregroundColor: Color(0xFFFFFFFF),
      ),
      body: Center(
        child:Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            children: [

              TextField(
                decoration: InputDecoration(
                  hintText: "Email",
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                decoration: InputDecoration(
                  hintText: "Password",
                ),
              ),
              SizedBox(height: 20,),
              ElevatedButton(
                onPressed: () {
                  // Call the register function here
                },
                child: Text("Sign Up"),
                style:ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFF1A237E),
                  foregroundColor: Colors.white ,
                ) ,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
