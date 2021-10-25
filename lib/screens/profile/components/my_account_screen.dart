import 'package:farmersapp_edi/components/rounded_button.dart';
import 'package:farmersapp_edi/components/text_field_container.dart';
import 'package:farmersapp_edi/constants.dart';
import 'package:farmersapp_edi/size_config.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyAccountScreen extends StatefulWidget {
  final User user;
  final FirebaseAuth auth = FirebaseAuth.instance;
  MyAccountScreen(this.user);
  @override
  _MyAccountScreenState createState() => _MyAccountScreenState(this.user);
}

class _MyAccountScreenState extends State<MyAccountScreen> {
  User user;
  _MyAccountScreenState(this.user);
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController controllerName = TextEditingController();
  TextEditingController controllerMobile = TextEditingController();
  final dbRef_users = FirebaseDatabase.instance.reference().child("Users");
  List param = ['name', 'mobile'];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(user.uid.toString())
        .once()
        .then((DataSnapshot dataSnapshot) async {
      Map<String, String> map = Map.from(dataSnapshot.value);
      if (dataSnapshot.value != null) {
        controllerName.text =
            (map.containsKey('name') ? map['name'] : "Add name")!;
        controllerMobile.text =
            (map.containsKey('mobile') ? map['mobile'] : "Add mobile")!;
        print(map.toString());
      }
    });

    // FutureBuilder(
    //     future: dbRef_users.child(user.uid).once(),
    //     builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {

    //     });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Account'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 10),
                  Text(
                    "Complete Profile",
                    style: headingStyle,
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Complete your details or continue  \nwith social media",
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 5),
                  TextFieldContainer(
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.photo_camera_front_outlined,
                          color: kPrimaryColor,
                        ),
                        hintText: "Add Your Name..",
                        border: InputBorder.none,
                      ),
                      controller: controllerName,
                    ),
                  ),
                  SizedBox(height: 5),
                  TextFieldContainer(
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.photo_camera_front_outlined,
                          color: kPrimaryColor,
                        ),
                        hintText: "Add Your Mobile..",
                        border: InputBorder.none,
                      ),
                      controller: controllerMobile,
                    ),
                  ),
                  SizedBox(height: 5),
                  RoundedButton(
                    text: "UPDATE/ADD DETAILS",
                    press: () => FirebaseDatabase.instance
                        .reference()
                        .child("Users")
                        .child(user.uid)
                        .set({
                      'name': controllerName.text,
                      'mobile': controllerMobile.text
                    }),
                  ),
                  Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void addUserDetails() {
  //   // dbRef_users.set({'firstname': 'shyam', 'mobile': 'mobile'});
  //   dbRef_users.child('shyam').set({'name': "shyam kawale"});
  //   // dbRef_users.once().then((DataSnapshot dataSnapshot) async {
  //   //   Map<dynamic, dynamic> map = Map.from(dataSnapshot.value);
  //   //   if (dataSnapshot.value != null) {
  //   //     print(dataSnapshot.value.toString());
  //   //     print(map.toString());
  //   //   }
  //   // });
  // }

  // final nameField = TextFieldContainer(
  //   child: TextField(
  //     cursorColor: kPrimaryColor,
  //     decoration: InputDecoration(
  //       icon: Icon(
  //         Icons.photo_camera_front_outlined,
  //         color: kPrimaryColor,
  //       ),
  //       hintText: "Your Name",
  //       border: InputBorder.none,
  //     ),
  //     controller: controllerName,
  //     // decoration: InputDecoration(
  //     //     contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
  //     //     hintText: "Name",
  //     //     border:
  //     //         OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
  //   ),
  // );

  // TextFormField buildFirstNameFormField() {
  //   return TextFormField(
  //     onSaved: (newValue) => firstName = newValue,
  //     onChanged: (value) {
  //       if (value.isNotEmpty) {
  //         removeError(error: kNamelNullError);
  //       }
  //       return null;
  //     },
  //     validator: (value) {
  //       if (value!.isEmpty) {
  //         addError(error: kNamelNullError);
  //         return "";
  //       }
  //       return null;
  //     },
  //     decoration: InputDecoration(
  //       labelText: "First Name",
  //       hintText: "Enter your first name",
  //       // If  you are using latest version of flutter then lable text and hint text shown like this
  //       // if you r using flutter less then 1.20.* then maybe this is not working properly
  //       floatingLabelBehavior: FloatingLabelBehavior.always,
  //       suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/User.svg"),
  //     ),
  //   );

}
