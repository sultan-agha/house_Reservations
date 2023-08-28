import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:house_reservation/LoginScreen.dart';
import 'package:house_reservation/models/user_model.dart';
import 'package:house_reservation/services/auth_service.dart';

import 'HomePage.dart';
// taking data from user and save it in cloudstore
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState()=>_RegisterScreenState();

}
class _RegisterScreenState extends State<RegisterScreen> {
  //for pass
  bool _isPasswordVisible = true;
  bool _isCPasswordVisible = true;
  // for auth
  final _auth=FirebaseAuth.instance;
  // for form and controllers
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _controllerFirstName=TextEditingController();
  final TextEditingController _controllerLastName=TextEditingController();
  final TextEditingController _controllerEmail=TextEditingController();
  final TextEditingController _controllerPassword=TextEditingController();
  final TextEditingController _controllerConfirmPassword=TextEditingController();

  Color _RebuttonColor = Colors.purple;
  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size; //provides information about the media (display)
    return Scaffold(
      backgroundColor: const Color(0xffD6E2EA),
      appBar: AppBar(
        backgroundColor: const Color(0xffD6E2EA),
        title: const  Center(child: Text("Register")),
      ),
      body:  Form(
          key: _formKey,
          child: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //gif animation
                    SizedBox(
                        width:size.width,
                        height: 200,
                        child:  Image.asset("images/clap-hand.gif")
                    ),
                    const SizedBox(height: 10),
                    // for FirstName
                    TextFormField(
                      autofocus: false,
                      controller: _controllerFirstName,
                      onSaved: (value){
                        _controllerFirstName.text=value!;
                      },
                      //validation
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return ("First Name cant be empty ");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Please enter a valid Name(min 3 characters)");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration:
                      InputDecoration(
                          hintText: "First Name",
                          prefixIcon: const Icon(Icons.account_circle),// display an icon on the left side of the text field.
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                      ),
                    ),
                    const SizedBox(height: 10),
                    // for LastName
                    TextFormField(
                      autofocus: false,
                      controller: _controllerLastName,
                      onSaved: (value){
                        _controllerLastName.text=value!;
                      },
                      //validation
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{3,}$');
                        if (value!.isEmpty) {
                          return ("Last Name cant be empty ");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Please enter a valid Name(min 3 characters)");
                        }
                        return null;
                      },
                      keyboardType: TextInputType.name,
                      decoration:
                      InputDecoration(
                          hintText: "Last Name",
                          prefixIcon: const Icon(Icons.account_circle),// display an icon on the left side of the text field.
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                      ),
                    ),
                    const SizedBox(height: 10),
                    // for email address
                    TextFormField(
                      autofocus: false,
                      controller: _controllerEmail,
                      onSaved: (value){
                        _controllerEmail.text=value!;
                      },
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
                      keyboardType: TextInputType.emailAddress,
                      decoration:
                      InputDecoration(
                          hintText: "E_mail",
                          prefixIcon: const Icon(Icons.mail),// display an icon on the left side of the text field.
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                      ),
                    ),
                    const SizedBox(height: 10),
                    // for password
                    TextFormField(
                      controller: _controllerPassword,
                      obscureText: _isPasswordVisible, // to hide the pass
                      onSaved: (value){
                        _controllerPassword.text=value!;
                      },
                      //validation
                      validator: (value) {
                        RegExp regex = RegExp(r'^.{6,}$');
                        if (value!.isEmpty) {
                          return ("Password is required for registering");
                        }
                        if (!regex.hasMatch(value)) {
                          return ("Please enter a valid password(min 6 characters");
                        }
                      },
                      decoration: InputDecoration(
                          hintText: "Password",
                          prefixIcon: const Icon(Icons.lock),// display an icon on the left side of the text field.
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
                    const SizedBox(height: 10,),

                    // for confirm password
                    TextFormField(
                      controller: _controllerConfirmPassword,
                      autofocus: false,
                      obscureText: _isCPasswordVisible, // to hide the pass
                      onSaved: (value){
                        _controllerConfirmPassword.text=value!;
                      },
                      //validation
                      validator: (value) {
                        if(_controllerConfirmPassword.text!=_controllerPassword.text){
                          return "Password don't match";
                        }
                        return null ;
                      },

                      decoration: InputDecoration(
                          hintText: "Confirm Password",
                          prefixIcon: const Icon(Icons.lock),// display an icon on the left side of the text field.
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isCPasswordVisible = !_isCPasswordVisible;
                              });
                            },
                            child: Icon(
                              _isCPasswordVisible ? Icons.visibility_off :
                              Icons.visibility,
                            ),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                          )
                      ),
                    ),
                    const SizedBox(height: 10,),
                    // for login button
                    MaterialButton(
                      minWidth: size.width,
                      height: 50,
                      color: _RebuttonColor,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      onPressed: (){
                        //check if the email and pass is correct and is filled else give an alert dialog
                        register(_controllerEmail.text, _controllerPassword.text);
                      },
                      child: const Text("Sign Up",style: TextStyle(
                        color: Colors.white,
                      ),),).animate().slide(duration: 2.seconds),
                    const SizedBox(height: 10,),
                    //for already have an account
                    SizedBox(
                      width: size.width,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already have an account?"),
                          //for register button
                          TextButton(onPressed: (){
                            // to do register button
                            Navigator.push(context,MaterialPageRoute(builder: (_)=>const LoginScreen()));
                          },
                            child: const Text("Sign in",style: TextStyle(
                                color:Colors.blue
                            ),),)//animate
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
    );
  }
  //function for sign up
void register(String email,String password) async
{
  if(_formKey.currentState!.validate()){
    await _auth.createUserWithEmailAndPassword(email: email, password: password)
        .then((value) => {
          postDetailsToFirestore()
    }).catchError((e){
      Fluttertoast.showToast(msg: e!.message);
    });
  }
}
// to post details to firestore

  postDetailsToFirestore() async{
    //calling firestore
    FirebaseFirestore  firebaseFirestore =FirebaseFirestore.instance;
    User? user=_auth.currentUser;
    //calling our user model
    UserModel userModel =UserModel();
    //writing all the values
    userModel.email=user!.email;
    userModel.uid=user.uid;
    userModel.firstName=_controllerFirstName.text;
    userModel.lastName=_controllerLastName.text;

    await firebaseFirestore
    .collection("users")
    .doc(user.uid)
    .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :)");
    //sending these values
    _RechangeButtonColor(context);
    Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomePage())).then((_) {
      // Reset the background color when you return to the previous page.
      setState(() {
        _RebuttonColor = Colors.purple;
      });});
  }
  void _RechangeButtonColor(BuildContext context) async {
    // Change the button color when pressed
    setState(() {
      _RebuttonColor = Colors.blueAccent;// You can change the color as desired

    });
    await Future.delayed(const Duration(milliseconds: 100), () {});
  }
}
