import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:house_reservation/main.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize{

  @override
  Widget build(BuildContext context) {
    return  SafeArea(
        child: Container(
            padding:const EdgeInsets.symmetric(horizontal: 15),
       child:  Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(onPressed: (){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const LoginPage(),
              ));
        },
            icon: SvgPicture.asset('images/menu.svg')),
        const CircleAvatar(
          backgroundImage: AssetImage('images/avatar.png'),
        )
      ],
    )));

  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(50);

  @override
  // TODO: implement child
  Widget get child => throw UnimplementedError();
}
