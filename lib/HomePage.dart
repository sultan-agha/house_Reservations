
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:house_reservation/main.dart';
import 'package:house_reservation/widget/best_offer.dart';
import 'package:house_reservation/widget/categories.dart';
import 'package:house_reservation/widget/custom_app_bar.dart';
import 'package:house_reservation/models/user_model.dart';
import 'package:house_reservation/widget/custom_buttom_navigation_bar.dart';
import 'package:house_reservation/widget/reccomended_house.dart';
import 'package:house_reservation/widget/search_input.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState()=>_HomePageState();

}
class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Intercept the back button press
        SystemNavigator.pop(); // Close the app
        return false; // Return false to prevent default behavior
      },
      child: HomePage(),
    );
  }
}
class _HomePageState extends State<HomePage> {
  // to get the data and print them
  User? user=FirebaseAuth.instance.currentUser;
  UserModel loginUser=UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      loginUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // make logout menu
      appBar: CustomAppBar(),
      drawer: SafeArea(
        // i can use drawer header instead of container
        child: Drawer(child: Column(
          children: [
            Container(
              height: 150, // Set the desired height of the header
              color: Colors.grey, // Customize the background color
              alignment: Alignment.center,
              child: const Text(
                'Menu',
                style: TextStyle(fontSize: 50, color: Colors.black),
              ),
            ),

            ListTile(
              onTap: () {
                logout(context);
              },
              leading: const Icon(Icons.logout),
              title: const Text(
                "sign out", style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
              ),
            )
          ],
        ),
        ),
      ),
      backgroundColor: const Color(0xffD6E2EA),
      body:  SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
               const Text("Welcome Back",style: TextStyle(
              fontSize: 20,fontWeight: FontWeight.bold
            ),),
            const SizedBox(height: 10,),
                //we took the value
                Text("${loginUser.firstName }  ${loginUser.lastName }",
                  style: const TextStyle(color: Colors.black54,fontWeight: FontWeight.w500,
                      fontSize: 25),),
                const SizedBox(height: 10,),
                const Text("Find your sweet home ",style: TextStyle(
                    fontSize: 20,fontWeight: FontWeight.bold
                ),),
                const SizedBox(height: 10,),
                // for the searchbar
                SearchInput(),
                //for categories
                Categories(),
                //for houses
                RecommendedHouse(),
                //for offers
                BestOffer(),
              ],
            )
          ),),
      ),
            bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
  // for logout
Future<void> logout(BuildContext context) async
{
  await FirebaseAuth.instance.signOut();
  Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (BuildContext context) {
        return const MyApp();
      }));
}
}