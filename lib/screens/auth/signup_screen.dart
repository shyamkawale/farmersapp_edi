import 'package:farmersapp_edi/components/already_have_an_account_acheck.dart';
import 'package:farmersapp_edi/components/or_divider.dart';
import 'package:farmersapp_edi/components/rounded_button.dart';
import 'package:farmersapp_edi/components/rounded_input_field.dart';
import 'package:farmersapp_edi/components/rounded_password_field.dart';
import 'package:farmersapp_edi/components/social_icon.dart';
import 'package:farmersapp_edi/components/text_field_container.dart';
import 'package:farmersapp_edi/constants.dart';
import 'package:farmersapp_edi/screens/auth/login_screen.dart';
import 'package:farmersapp_edi/screens/home/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/cupertino.dart';
// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
// import 'package:toast/toast.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  TextEditingController mobile_controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Firebase.initializeApp().whenComplete(() {
    //   print("completed");
    //   setState(() {});
    // });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: size.height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Positioned(
              top: 0,
              left: 0,
              child: Image.asset(
                "assets/images/signup_top.png",
                width: size.width * 0.35,
              ),
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Image.asset(
                "assets/images/main_bottom.png",
                width: size.width * 0.25,
              ),
            ),
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/icons/signup.svg",
                    height: size.height * 0.3,
                  ),
                  SizedBox(height: size.height * 0.03),
                  Text(
                    "SIGNUP",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: size.height * 0.02),
                  TextFieldContainer(
                    child: TextField(
                      controller: email_controller,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.email,
                          color: kPrimaryColor,
                        ),
                        hintText: "Email",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // TextFieldContainer(
                  //   child: TextField(
                  //     controller: mobile_controller,
                  //     cursorColor: kPrimaryColor,
                  //     decoration: InputDecoration(
                  //       icon: Icon(
                  //         Icons.phone_android,
                  //         color: kPrimaryColor,
                  //       ),
                  //       hintText: "Mobile",
                  //       border: InputBorder.none,
                  //     ),
                  //   ),
                  // ),
                  TextFieldContainer(
                    child: TextField(
                      controller: password_controller,
                      cursorColor: kPrimaryColor,
                      decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: kPrimaryColor,
                        ),
                        suffixIcon: Icon(
                          Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        hintText: "Password",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  RoundedButton(
                    text: "SIGNUP",
                    press: signUpWithEmailPass,
                    // press: () {
                    //   // print(email_controller.text);
                    //   // print(password_controller.text);
                    // },
                    // press: () {
                    //   Navigator.push(context,
                    //       MaterialPageRoute(builder: (context) => HomePage()));
                    // },
                  ),
                  SizedBox(height: size.height * 0.03),
                  AlreadyHaveAnAccountCheck(
                    login: false,
                    press: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                  ),
                  Text(
                    "By continuing your confirm that you agree \nwith our Term and Condition",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.caption,
                  ),
                  OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocalIcon(
                        iconSrc: "assets/icons/facebook.svg",
                        press: () {},
                      ),
                      SocalIcon(
                        iconSrc: "assets/icons/twitter.svg",
                        press: () {},
                      ),
                      SocalIcon(
                        iconSrc: "assets/icons/google-plus.svg",
                        press: () {},
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void signUpWithEmailPass() async {
    User user;
    try {
      user = (await auth.createUserWithEmailAndPassword(
          email: email_controller.text,
          password: password_controller.text)) as User;
    } catch (e) {
      print(e);
    } finally {
      // Toast.show("Registration Successful!", context);
      Navigator.pop(context);
    }
  }
}
