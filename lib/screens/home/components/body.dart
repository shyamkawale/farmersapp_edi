import 'package:farmersapp_edi/size_config.dart';
import 'package:flutter/material.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [SizedBox(height: 20), Text("hello")],
        ),
      ),
    ));
  }
}
