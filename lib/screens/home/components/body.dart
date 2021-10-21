import 'package:farmersapp_edi/components/rounded_button.dart';
import 'package:farmersapp_edi/size_config.dart';
import 'package:flutter/material.dart';
import 'package:farmersapp_edi/screens/Prediction_modules/predModel.dart';

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            Text("hello"),
            RoundedButton(
                text: "Crop Pred",
                press: () {
                  // Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => //crop pred file),
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>PredModel()));
                  //             );
                }),
            RoundedButton(
                text: "Fertilizer Pred",
                press: () {
                  // Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => //ferti pred file),
                  //             );
                }),
            RoundedButton(
                text: "Crop Pred",
                press: () {
                  // Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => //crop pred file),
                  //             );
                }),
            RoundedButton(
                text: "Plant Diesease det.",
                press: () {
                  // Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => //plant disease det file),
                  //             );
                }),
            RoundedButton(
                text: "extra button",
                press: () {
                  // Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => //crop pred file),
                  //             );
                }),
            RoundedButton(
                text: "extra button",
                press: () {
                  // Navigator.push(
                  //               context,
                  //               MaterialPageRoute(
                  //                   builder: (context) => //crop pred file),
                  //             );
                })
          ],
        ),
      ),
    ));
  }
}
