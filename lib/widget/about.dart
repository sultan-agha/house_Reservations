import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'About',
            style: Theme.of(context)
                .textTheme
                .displayLarge!
                .copyWith(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 10,
          ),
          Text("Nestled in a charming neighborhood, a cozy house stands surrounded by gardens and trees. Inside, sunlight dances on hardwood floors in the spacious living room. The kitchen is a modern haven, and upstairs, peaceful bedrooms await, each with its unique charm. With a master bedroom balcony for sunrise coffee, this house is a place where memories thrive and comfort abounds.",
            style:
            Theme.of(context).textTheme.bodyLarge!.copyWith(fontSize: 14),
          )
        ],
      ),
    );
  }
}