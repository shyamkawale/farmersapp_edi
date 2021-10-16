import 'package:farmersapp_edi/components/already_have_an_account_acheck.dart';
import 'package:farmersapp_edi/components/loading.dart';
import 'package:farmersapp_edi/components/rounded_button.dart';
import 'package:farmersapp_edi/components/rounded_input_field.dart';
import 'package:farmersapp_edi/components/rounded_password_field.dart';
import 'package:farmersapp_edi/components/text_field_container.dart';
import 'package:farmersapp_edi/constants.dart';
import 'package:farmersapp_edi/screens/auth/signup_screen.dart';
import 'package:farmersapp_edi/screens/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  TextEditingController email_controller = TextEditingController();
  TextEditingController password_controller = TextEditingController();
  bool loading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return loading
        ? Loading(
            container_color: kPrimaryLightColor,
            loadingtype: SpinKitFadingCircle(
              color: Colors.brown,
              size: 100,
            ),
          )
        : Scaffold(
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
                      "assets/images/main_top.png",
                      width: size.width * 0.35,
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      "assets/images/login_bottom.png",
                      width: size.width * 0.4,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "LOGIN",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: size.height * 0.03),
                        SvgPicture.asset(
                          "assets/icons/login.svg",
                          height: size.height * 0.35,
                        ),
                        SizedBox(height: size.height * 0.03),
                        // RoundedInputField(
                        //   hintText: "Your Email",
                        //   onChanged: (value) {},
                        // ),
                        TextFieldContainer(
                          child: TextField(
                            controller: email_controller,
                            cursorColor: kPrimaryColor,
                            decoration: InputDecoration(
                              // enabledBorder: OutlineInputBorder(
                              //     borderSide:
                              //         BorderSide(color: kPrimaryColor, width: 2.0)),
                              icon: Icon(
                                Icons.email,
                                color: kPrimaryColor,
                              ),
                              hintText: "Your Email",
                              border: InputBorder.none,
                              // enabledBorder: OutlineInputBorder(
                              //     borderSide:
                              //         BorderSide(color: Colors.red, width: 2.0)),
                            ),
                          ),
                        ),
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
                          text: "LOGIN",
                          press: loginWithEmailPass,
                        ),
                        SizedBox(height: size.height * 0.03),
                        AlreadyHaveAnAccountCheck(
                          press: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SignUpScreen()),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
  }

  void loginWithEmailPass() async {
    setState(() {
      loading = true;
    });
    try {
      var user = (await auth.signInWithEmailAndPassword(
              // email: email_controller.text, password: password_controller.text))
              email: "s@gmail.com",
              password: "123456"))
          .user;
      String userid = user!.uid;
      if (userid != null) {
        setState(() {
          loading = false;
        });
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => HomePage(user.uid)));
      } else {
        Container(
          child: AlertDialog(
            actions: <Widget>[
              Text("password is incorrect"),
            ],
          ),
        );
      }
    } catch (e) {
      print("shyam::::" + e.toString());
    } finally {}
  }
}
