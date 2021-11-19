import 'package:farmersapp_edi/components/custom_bottom_nav_bar.dart';
import 'package:farmersapp_edi/enums.dart';
import 'package:farmersapp_edi/screens/marketplace/components/body.dart';
import 'package:farmersapp_edi/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

// import 'components/body.dart';

class MarketScreen extends StatelessWidget {
  final User user;
  final Map user_details;

  const MarketScreen(this.user, this.user_details);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: customAppBar("Market Screen"),
      body: SafeArea(child: MarketBody(user, user_details)),
      bottomNavigationBar:
          CustomBottomNavBar(user: user, selectedMenu: MenuState.message),
    );
  }
}
