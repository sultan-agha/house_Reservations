import 'package:flutter/material.dart';
import 'package:house_reservation/widget/about.dart';
import 'package:house_reservation/widget/content_intro.dart';
import 'package:house_reservation/widget/detail_appbar.dart';
import 'package:house_reservation/widget/house_info.dart';
import 'package:url_launcher/url_launcher.dart';

import 'models/house.dart';

class DetailPage extends StatelessWidget {
  // i need house model since i will use it
  final House house;
  const DetailPage({Key? key, required this.house}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailAppBar(house: house),
                const SizedBox(height: 20),
                ContentIntro(house: house),
                const SizedBox(height: 20),
                HouseInfo(),
                const SizedBox(height: 20),
                About(),
                const SizedBox(height: 25),
                Container(
                  alignment: Alignment.center,
                  child: const Text( "Here is my phone number ",style: TextStyle(
                    fontSize: 20,
                    color: Colors.blueAccent
                  ),),
                ),
                const SizedBox(height: 15),
                Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: ElevatedButton(
                        onPressed: () async{
                          const phoneNumber="tel:+96170754210";
                          if(!await launchUrl(
                          Uri.parse(phoneNumber),
                              mode: LaunchMode.externalApplication,
                          )){
                            throw Exception('could not launch $phoneNumber');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8)),
                          backgroundColor: Theme.of(context).primaryColor,
                        ),
                        child: Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            child: const Text('Contact Me',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)))))
              ],
            ))
                   );
   }
}