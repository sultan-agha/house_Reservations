import 'package:flutter/material.dart';
import '../detail_page.dart';
import '../models/house.dart';
import 'circle_icon_button.dart';

class RecommendedHouse extends StatelessWidget {
  final recommendedList = House.generateRecommended();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      height: 340,
      //used to display a scrollable list of items
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) {
                return DetailPage(house: recommendedList[index]);
              }));
            },
            child: Container(
              width: 230,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(8)),
              //stack widget is used to layer objects above each other
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                          // to see the images
                            image: AssetImage(
                              recommendedList[index].imageUrl,
                            ),
                            fit: BoxFit.cover)),
                  ),
                  // the place to be stacked
                  Positioned(
                    right: 15,
                    top: 15,
                    child: CircleIconButton(
                        iconUrl: 'images/heart.svg',
                        color: Theme.of(context).primaryColor),
                  ),
                  Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        color: Colors.white54,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(recommendedList[index].name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(
                                  recommendedList[index].address,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                            CircleIconButton(
                                iconUrl: 'images/mark.svg',
                                color: Theme.of(context).primaryColor)
                          ],
                        ),
                      ))
                ],
              ),
            ),
          ),
          separatorBuilder: (_, index) => const SizedBox(width: 20),
          itemCount: recommendedList.length),
    );
  }
}