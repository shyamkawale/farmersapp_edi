import 'package:farmersapp_edi/components/custom_bottom_nav_bar.dart';
import 'package:farmersapp_edi/enums.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'components/body.dart';

class ProfileScreen extends StatelessWidget {
  final User user;

  const ProfileScreen(this.user);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
      ),
      body: Body(user),
      bottomNavigationBar:
          CustomBottomNavBar(user: user, selectedMenu: MenuState.profile),
    );
  }
}
