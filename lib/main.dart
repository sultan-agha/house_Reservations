import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:house_reservation/LoginScreen.dart';
import 'package:house_reservation/RegisterScreen.dart';
//for auth
Future<void> main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key,});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Color _LbuttonColor = Colors.blue;// Initial button color
  Color _RbuttonColor = Colors.transparent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title:const Center(child:  Text("Home",textAlign: TextAlign.center,style: TextStyle(
          color: Colors.white
        ),)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/rubber-welcome-5.png'),
          const SizedBox(height: 20),
          const  Text(
              'Welcome',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white
              ),
            ),
          const SizedBox(height: 40),
            //for login
            Animate(
              effects: [FadeEffect(), ScaleEffect()],
              child: MaterialButton(
                onPressed: () {
                  _LchangeButtonColor(context);
                  // Handle login button press

                },
                color: _LbuttonColor, // Button background color
                textColor: Colors.black, // Button text color
                padding:const EdgeInsets.symmetric(horizontal: 150, vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ).animate().slide(duration:1.seconds),
            ),
            const SizedBox(height: 20),
            //for register
            MaterialButton(
              onPressed: () {
                _RchangeButtonColor(context);
                // Handle register button press
                  },
              color: _RbuttonColor, // Button background color
              textColor: Colors.blue, // Button text color
              padding:const EdgeInsets.symmetric(horizontal: 140, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
                side: const BorderSide(color: Colors.blue), // Button border color
              ),
              child: const Text(
                'Register',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ).animate().slide(duration:1.seconds),
          ],
        ),
      ),
    );
  }
  void _LchangeButtonColor(BuildContext context) async {
    // Change the button color when pressed
    setState(() {
      _LbuttonColor = Colors.purple; // You can change the color as desired
    });
    await Future.delayed(const Duration(milliseconds: 100), () {});
    Navigator.push(context,MaterialPageRoute(builder: (_)=>const LoginScreen())).then((_) {
      // Reset the background color when you return to the previous page.
      setState(() {
        _LbuttonColor = Colors.blue;
      });});
  }

  void _RchangeButtonColor(BuildContext context) async {
    // Change the button color when pressed
    setState(() {
      _RbuttonColor = Colors.purple; // You can change the color as desired
    });
    await Future.delayed(const Duration(milliseconds: 100), () {});
    Navigator.push(context,MaterialPageRoute(builder: (_)=>const RegisterScreen())
    ).then((_) {
      // Reset the background color when you return to the previous page.
      setState(() {
        _RbuttonColor = Colors.transparent;
      });});
  }
}
