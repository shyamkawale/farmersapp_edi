import 'package:farmersapp_edi/components/custom_bottom_nav_bar.dart';
import 'package:farmersapp_edi/screens/home/components/body.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class HomePage extends StatefulWidget {
  final User user;
  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState(this.user);
}

class _HomePageState extends State<HomePage> {
  User user;
  _HomePageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(user),
      bottomNavigationBar:
          CustomBottomNavBar(user: user, selectedMenu: MenuState.home),
    );
  }
}
