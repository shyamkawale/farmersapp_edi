// import 'dart:ffi';
import 'dart:io';

import 'package:farmersapp_edi/components/rounded_button.dart';
import 'package:farmersapp_edi/components/text_field_container.dart';
import 'package:farmersapp_edi/constants.dart';
import 'package:farmersapp_edi/size_config.dart';
import 'package:farmersapp_edi/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:velocity_x/velocity_x.dart';

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
  TextEditingController controllerUserName = TextEditingController();
  TextEditingController controllerFirstName = TextEditingController();
  TextEditingController controllerLastName = TextEditingController();
  TextEditingController controllerMobile = TextEditingController();
  // TextEditingController controllerAddress = TextEditingController();

  // TextEditingController controllerUserName = TextEditingController();

  final dbRef_users = FirebaseDatabase.instance.reference().child("Users");
  final ImagePicker _picker = ImagePicker();
  final List<Map> address = [
    {"city": "akola", "pincode": 444004},
    {"city": "pune", "pincode": 413037}
  ];
  // List param = ['username', 'firstname', 'lastname', 'mobile'];
  late XFile _image;
  String cloudimagepath = "";
  final List<String> sellingitemslist = ["0"];
  final List<String> orderslist = ["0"];

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
      Map<dynamic, dynamic> map = Map.from(dataSnapshot.value);
      if (dataSnapshot.value != null) {
        controllerUserName.text =
            (map.containsKey('username') ? map['username'] : "")!;
        controllerFirstName.text =
            (map.containsKey('firstname') ? map['firstname'] : "")!;
        controllerLastName.text =
            (map.containsKey('lastname') ? map['lastname'] : "")!;
        controllerMobile.text =
            (map.containsKey('mobile') ? map['mobile'] : "")!;
        print(map.toString());
        setState(() {
          cloudimagepath =
              (map.containsKey('profilepic') ? map['profilepic'] : "");
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Future uploadImage(BuildContext context) async {
      String fileName = basename(_image.path);
      File file = File(_image.path);
      try {
        await FirebaseStorage.instance
            .ref()
            .child("/users")
            .child(fileName)
            .putFile(file);
        String downloadlink = await FirebaseStorage.instance
            .ref()
            .child("/users")
            .child(fileName)
            .getDownloadURL();
        setState(() {
          cloudimagepath = downloadlink;
          print("new file path: " + cloudimagepath);
        });
      } on FirebaseException catch (e) {
        // e.g, e.code == 'canceled'
        print("image uploading crash");
      }
    }

    Future getImageGallery() async {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image!;
        print('Image Path: ' + _image.path);
      });
      uploadImage(context);
    }

    return Scaffold(
      appBar: customAppBar("My Account"),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 1),
                  Text(
                    "Complete Your Profile",
                    style: headingStyle,
                  ),
                  SizedBox(height: 4),
                  // Text(
                  //   "Complete/Update your details",
                  //   textAlign: TextAlign.center,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Padding(padding: EdgeInsets.all(10)),
                      Align(
                        alignment: Alignment.center,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.black45,
                          child: ClipOval(
                            child: new SizedBox(
                                width: 95.0,
                                height: 95.0,
                                child: (cloudimagepath == "")
                                    ? Image.asset(
                                        "assets/icons/farmer user.ico",
                                        fit: BoxFit.fill,
                                      )
                                    : Image.network(
                                        cloudimagepath,
                                        fit: BoxFit.fill,
                                      )),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 30.0),
                        child: IconButton(
                          icon: Icon(
                            Icons.camera_alt,
                            size: 30.0,
                          ),
                          onPressed: () {
                            getImageGallery();
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4),
                  TextFieldContainer(
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.photo_camera_front_outlined,
                          color: kPrimaryColor,
                        ),
                        hintText: "Add Your UserName..",
                        border: InputBorder.none,
                      ),
                      controller: controllerUserName,
                    ),
                  ),
                  SizedBox(height: 2),
                  TextFieldContainer(
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.photo_camera_front_outlined,
                          color: kPrimaryColor,
                        ),
                        hintText: "Add Your FirstName..",
                        border: InputBorder.none,
                      ),
                      controller: controllerFirstName,
                    ),
                  ),
                  SizedBox(height: 2),
                  TextFieldContainer(
                    child: TextField(
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.photo_camera_front_outlined,
                          color: kPrimaryColor,
                        ),
                        hintText: "Add Your LastName..",
                        border: InputBorder.none,
                      ),
                      controller: controllerLastName,
                    ),
                  ),
                  SizedBox(height: 2),
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
                  SizedBox(height: 2),
                  RoundedButton(
                      text: "UPDATE/ADD DETAILS",
                      press: () {
                        try {
                          FirebaseDatabase.instance
                              .reference()
                              .child("Users")
                              .child(user.uid)
                              .set({
                            'username': controllerUserName.text,
                            'firstname': controllerFirstName.text,
                            'lastname': controllerLastName.text,
                            'mobile': controllerMobile.text,
                            'address': address,
                            'profilepic': cloudimagepath,
                            'sellingitems': sellingitemslist,
                            'orderslist': orderslist,
                          });
                          VxToast.show(context,
                              msg: "your details are updated succesfully",
                              position: VxToastPosition.top,
                              textColor: Colors.blue,
                              bgColor: Colors.white);
                        } catch (e) {
                          VxToast.show(context,
                              msg: e.toString(),
                              position: VxToastPosition.top,
                              showTime: 4000,
                              textColor: Colors.red,
                              bgColor: Colors.white);
                        }
                      }),
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
