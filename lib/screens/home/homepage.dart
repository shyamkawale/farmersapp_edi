import 'package:farmersapp_edi/components/custom_bottom_nav_bar.dart';
import 'package:farmersapp_edi/screens/home/components/body.dart';
import 'package:flutter/material.dart';

import '../../enums.dart';

class HomePage extends StatefulWidget {
  final String user;
  HomePage(this.user);

  @override
  _HomePageState createState() => _HomePageState(this.user);
}

class _HomePageState extends State<HomePage> {
  String user;
  _HomePageState(this.user);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Body(),
      bottomNavigationBar: CustomBottomNavBar(selectedMenu: MenuState.home),
    );
  }
}
