import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_reservation/HomePage.dart';
import 'package:house_reservation/RegisterScreen.dart';
import 'package:house_reservation/forgot_pass_screen.dart';
import 'package:house_reservation/services/auth_service.dart';
import 'package:rive/rive.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState()=>_LoginScreenState();

}
class _LoginScreenState extends State<LoginScreen> {
  // To DO the animation
  StateMachineController? controller; // manages the state transitions and actions of a state machine.
  SMIInput<bool>? isChecking; // represents an input signal to the state machine
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
//for pass
  bool _isPasswordVisible = true;
  // for firebase
  final _auth = FirebaseAuth.instance;

  //for checking fields
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

  Future<void> signInWithEmailAndPassword() async {
    try {
      await Auth().signInWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        //errorMessage=e.message;
      });
    }
  }

  Future<void> createUserWithEmailAndPassword() async {
    try {
      await Auth().createUserWithEmailAndPassword(
          email: _controllerEmail.text, password: _controllerPassword.text);
    } on FirebaseAuthException catch (e) {
      setState(() {
        //errorMessage=e.message;
      });
    }
  }
  Color _LobuttonColor = Colors.purple;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery
        .of(context)
        .size; //provides information about the media (display)
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffD6E2EA),
        title: const Text("Login"),
      ),
      backgroundColor: const Color(0xffD6E2EA),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //rive animation
                  SizedBox(
                      width: size.width,
                      height: 200,
                      child: RiveAnimation.asset(
                        "images/animated-login-character.riv",
                        stateMachines: ["Login Machine"],
                        onInit: (
                            artboard) // executed when the Rive animation is initialized and loaded.
                        {
                          // If the controller is successfully created, it's added to the artboard.
                          controller = StateMachineController.fromArtboard(
                              artboard, "Login Machine");
                          if (controller == null) return;

                          artboard.addController(controller!);
                          isChecking = controller?.findInput("isChecking");
                          isHandsUp = controller?.findInput("isHandsUp");
                          trigSuccess = controller?.findInput("trigSuccess");
                          trigFail = controller?.findInput("trigFail");
                        },
                      )
                  ),
                  const SizedBox(height: 10),

                  // for email field
                  TextFormField(
                    autofocus: false,
                    controller: _controllerEmail,
                    // for rive animation
                    onChanged: (value) {
                      if (isHandsUp != null) {
                        isHandsUp!.change(false);
                      }
                      if (isChecking == null) return;
                      isChecking!.change(true);
                    },
                    onSaved: (value) {
                      _controllerEmail.text = value!;
                    },
                    // continue
                    keyboardType: TextInputType.emailAddress,
                    //validation
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
                        hintText: "E_mail",
                        prefixIcon: const Icon(Icons.mail),
                        // display an icon on the left side of the text field.
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                  ),
                  const SizedBox(height: 10),


                  // for password
                  TextFormField(
                    controller: _controllerPassword,
                    onChanged: (value) {
                      if (isChecking != null) {
                        isChecking!.change(false);
                      }
                      if (isHandsUp == null) return;
                      isHandsUp!.change(true);
                    },
                    //validation
                    validator: (value) {
                      RegExp regex = RegExp(r'^.{6,}$');
                      if (value!.isEmpty) {
                        return ("Password is required for login");
                      }
                      if (!regex.hasMatch(value)) {
                        return ("Please enter a valid password(min 6 characters");
                      }
                    },
                    onSaved: (value) {
                      _controllerPassword.text = value!;
                    },
                    obscureText: _isPasswordVisible,
                    // to hide the pass
                    decoration: InputDecoration(
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock),
                        // display an icon on the left side of the text field.
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isPasswordVisible = !_isPasswordVisible;
                            });
                          },
                          child: Icon(
                            _isPasswordVisible ? Icons.visibility_off :
                            Icons.visibility,
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        )
                    ),
                  ),
                  // for forgetting pass
                  SizedBox(
                    width: size.width,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ForgotPassScreen(),
                              ));
                        },
                        child: const Text(
                          "Forgot your password?",
                          textAlign: TextAlign.right,
                          style: TextStyle(decoration: TextDecoration.underline,
                              color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10,),
                  // for login button
                  MaterialButton(
                    minWidth: size.width,
                    height: 50,
                    color: _LobuttonColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                    onPressed: () {
                      //check if the email and pass is correct and is filled else give an alert dialog
                      signIn(_controllerEmail.text, _controllerPassword.text);
                    },
                    child: const Text("Login", style: TextStyle(
                      color: Colors.white,
                    ),),).animate().slide(duration: 2.seconds),
                  const SizedBox(height: 10,),
                  //for dnt have an account
                  SizedBox(
                    width: size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't you have an account?"),
                        TextButton(onPressed: () {
                          // to do register button
                          Navigator.push(context, MaterialPageRoute(
                              builder: (_) => const RegisterScreen()));
                        },
                          child: const Text("Register", style: TextStyle(
                              color: Colors.blue
                          ),),)
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }

//login function
  void signIn(String email, String password) async
  {
    //check if the validation is okay
    if (_formKey.currentState!.validate()) {
      await _auth.signInWithEmailAndPassword(email: email, password: password)
          .then((uid) =>
      {
        Fluttertoast.showToast(msg: "Login Successful"),
        _LochangeButtonColor(context),
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => const HomePage())).then((_) {
      // Reset the background color when you return to the previous page.
      setState(() {
      _LobuttonColor = Colors.purple;
      });})

    }).catchError((e) {
        Fluttertoast.showToast(msg: e!.message);
      });
    }
  }

  void _LochangeButtonColor(BuildContext context) async {
    // Change the button color when pressed
    setState(() {
      _LobuttonColor = Colors.blueAccent;// You can change the color as desired

    });
    await Future.delayed(const Duration(milliseconds: 100), () {});
  }
}