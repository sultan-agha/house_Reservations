import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HouseInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: const Column(
        children: [
          Row(
            children: [
              MenuInfo(
                  imageUrl: 'images/bedroom.svg',
                  content: '5 Bedroom\n3 Master Bedroom'),
              MenuInfo(
                  imageUrl: 'images/bathroom.svg',
                  content: '5 Bathroom\n3 Toilet'),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              MenuInfo(
                  imageUrl: 'images/kitchen.svg',
                  content: '2 Kitchen\n120 sqft'),
              MenuInfo(
                  imageUrl: 'images/parking.svg',
                  content: '2 Parking\n120 sqft'),
            ],
          )
        ],
      ),
    );
  }
}

class MenuInfo extends StatelessWidget {
  final String imageUrl;
  final String content;
  const MenuInfo({Key? key, required this.imageUrl, required this.content})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Expanded(
        child: Row(
          children: [
            SvgPicture.asset(imageUrl),
            const SizedBox(width: 20),
            Text(
              content,
              style:
              Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 12),
            )
          ],
        ),
      ),
    );
  }
}