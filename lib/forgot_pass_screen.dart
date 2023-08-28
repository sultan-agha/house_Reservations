import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:house_reservation/services/auth_service.dart';

class ForgotPassScreen extends StatefulWidget {
  const ForgotPassScreen({super.key});

  @override
  State<ForgotPassScreen> createState()=>_ForgotPassScreenState();

}
class _ForgotPassScreenState extends State<ForgotPassScreen> {
  final formKey=GlobalKey<FormState>();
  final TextEditingController _controller = TextEditingController(); //keep track what is inside
  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }
  Future passwordReset() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _controller.text.trim());
      showDialog(context: context, builder: (context) {
        return const AlertDialog(
          content: Text("Password reset link sent check your email"),
        );
      },
      );
    } on FirebaseAuthException catch (e) {
      print(e);
      showDialog(context: context, builder: (context){
        return AlertDialog(
          content: Text(e.message.toString()),
        );
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          "Forget Your Password?",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: false,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // for email
              Form(
                key: formKey,
                child: TextFormField(
                  controller: _controller,
                  onChanged: (value) {},
                  keyboardType: TextInputType.emailAddress,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return ("Please Enter a valid email");
                    }
                    //reg exp
                    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                        .hasMatch(value)) {
                      return ("Please Enter a valid email");
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              //reset password
              MaterialButton(
                minWidth: size.width * .5,
                height: 50,
                color: Colors.purple,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                onPressed: passwordReset,
                child: const Text(
                  "Send Link",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

}