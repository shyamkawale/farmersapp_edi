import 'package:farmersapp_edi/screens/auth/login_screen.dart';
import 'package:farmersapp_edi/screens/home/homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    // cameras = await availableCameras();
    // cameras_pickimage = await availableCameras();
  } on CameraException catch (e) {
    print('Error: $e.code\nError Message: $e.message');
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Farmers App EDI Project',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 10,
      navigateAfterSeconds: LoginScreen(),
      image: Image.asset(
        'assets/images/farmers.webp',
      ),
      loadingText: Text(
        "Opening.......",
        style: TextStyle(
            fontWeight: FontWeight.w300,
            fontStyle: FontStyle.italic,
            fontFamily: 'Open Sans',
            fontSize: 25),
      ),
      title: Text(
        "EDI PROJECT",
        style: TextStyle(
            color: Colors.lightGreenAccent[700],
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            fontFamily: 'Open Sans',
            fontSize: 40),
      ),
      photoSize: 150,
      backgroundColor: Colors.black38,
      loaderColor: Colors.green[900],
    );
  }
}
