import 'package:flutter/material.dart';

import '../models/house.dart';
import 'circle_icon_button.dart';


class BestOffer extends StatelessWidget {
  final listOfOffer = House.generateBestOffer();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Best Offer',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Text(
                'See All',
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const SizedBox(height: 10),
          //used to iterate over the listOfOffer and generate widgets for each offer.
          ...listOfOffer
              .map((el) => Container(
            margin: const EdgeInsets.only(bottom: 10),
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8)),
            child: Stack(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: 150,
                        height: 80,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(el.imageUrl),
                                fit: BoxFit.cover),
                            borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      children: [
                        Text(
                          el.name,
                          style: Theme.of(context)
                              .textTheme
                              .displayLarge!
                              .copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          el.address,
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 12),
                        )
                      ],
                    ),
                  ],
                ),
                const Positioned(
                  right: 0,
                  child: CircleIconButton(
                    iconUrl: 'images/heart.svg',
                    color: Colors.grey,
                  ),
                )
              ],
            ),
          ))
              .toList() // to get them from the list
        ],
      ),
    );
  }
}