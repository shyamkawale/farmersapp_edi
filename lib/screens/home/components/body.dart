import 'package:farmersapp_edi/components/rounded_button.dart';
import 'package:farmersapp_edi/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'package:farmersapp_edi/screens/Prediction_modules/predModel.dart';
import 'package:farmersapp_edi/screens/Prediction_modules/fertilizer.dart';

import 'package:flutter_spinkit/flutter_spinkit.dart';


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
                  if (snapshot.hasData) {
                    Map<String, String> map = Map.from(snapshot.data!.value);
                    print(map);
                    return (map.containsKey('name')
                        ? Text("Hello " + map['name'].toString())
                        : Text("No name"));
                  } else {
                    return Text("***Complete your profile***");
                  }
                }),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>Fertilizer()));
                  //             );
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
