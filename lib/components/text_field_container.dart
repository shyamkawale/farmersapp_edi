import 'package:flutter/material.dart';
import 'package:farmersapp_edi/constants.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  // final double margin;
  // final
  const TextFieldContainer({
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.symmetric(horizontal: 20),
      width: size.width * 0.9,
      height: 55,
      decoration: BoxDecoration(
        color: kPrimaryLightColor,
        borderRadius: BorderRadius.circular(29),
      ),
      child: child,
    );
  }
}
