import 'package:farmersapp_edi/components/category_card.dart';
import 'package:farmersapp_edi/components/rounded_button.dart';
import 'package:farmersapp_edi/screens/marketplace/marketscreen.dart';
import 'package:farmersapp_edi/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:farmersapp_edi/screens/Prediction_modules/predModel.dart';
import 'package:farmersapp_edi/screens/Prediction_modules/fertilizer.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class Body extends StatefulWidget {
  final User user;
  final FirebaseAuth auth = FirebaseAuth.instance;

  Body(this.user);

  @override
  _BodyState createState() => _BodyState(this.user);
}

class _BodyState extends State<Body> {
  User user;
  _BodyState(this.user);
  FirebaseAuth auth = FirebaseAuth.instance;
  dynamic user_name;
  Map<dynamic, dynamic> user_details = Map();
  final dbRef = FirebaseDatabase.instance.reference().child("Users");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 20),
            FutureBuilder(
                future: dbRef.child(user.uid).once(),
                builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                  try {
                    if (snapshot.hasData.toString() == "true") {
                      // print("aa" + snapshot.data.isBlank.toString());
                      // print("b" + snapshot.isBlank.toString());
                      // print("c" + snapshot.hasData.toString());
                      // print("d" + snapshot.data.toString());

                      Map<dynamic, dynamic> map =
                          Map.from(snapshot.data!.value);
                      user_details = map;
                      print(user_details);
                      return (map.containsKey('username')
                          ? Text("Hello " + map['username'].toString())
                          : Text("No name"));
                    }
                  } catch (e) {}
                  return Text("***Complete your profile***");
                }),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CategoryCard(
                      title: "Crop \n Prediction",
                      svgSrc: "assets/icons/Hamburger.svg",
                      press: () => Get.to(() => PredModel())),
                  CategoryCard(
                      title: "Fertilizer \n Prediction",
                      svgSrc: "assets/icons/Excrecises.svg",
                      press: () => Get.to(() => Fertilizer())),
                ],
              ),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CategoryCard(
                      title: "Market",
                      svgSrc: "assets/icons/Hamburger.svg",
                      press: () =>
                          Get.to(() => MarketScreen(user, user_details))),
                  CategoryCard(
                      title: "Plant Disease\n Detection",
                      svgSrc: "assets/icons/Excrecises.svg",
                      press: () {}),
                ],
              ),
            ),
            SizedBox(height: 7),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  CategoryCard(
                    title: "Chat Bot",
                    svgSrc: "assets/icons/Hamburger.svg",
                    press: () {},
                  ),
                  CategoryCard(
                    title: "Extra\n Button",
                    svgSrc: "assets/icons/Excrecises.svg",
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) {
                          return Fertilizer();
                        }),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
