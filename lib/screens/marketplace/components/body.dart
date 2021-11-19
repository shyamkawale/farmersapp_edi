import 'package:farmersapp_edi/components/rounded_button.dart';
import 'package:farmersapp_edi/components/small_card.dart';
import 'package:farmersapp_edi/screens/marketplace/components/buyer/buyer_screen.dart';
import 'package:farmersapp_edi/screens/marketplace/components/buyer/order_list_screen.dart';
import 'package:farmersapp_edi/screens/marketplace/components/seller/mysellingitems.dart';
import 'package:farmersapp_edi/screens/marketplace/components/seller/seller_screeen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class MarketBody extends StatefulWidget {
  final User user;
  final Map user_details;

  const MarketBody(this.user, this.user_details);

  @override
  _MarketBodyState createState() =>
      _MarketBodyState(this.user, this.user_details);
}

class _MarketBodyState extends State<MarketBody> {
  User user;
  Map user_details;
  _MarketBodyState(this.user, this.user_details);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              "Welcome To Market"
                  .toString()
                  .text
                  .xl5
                  .color(Color(0xff403b58))
                  .bold
                  .make(),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  'Hello Mr.'.text.xl2.color(Color(0xff403b58)).bold.make(),
                  SizedBox(
                    width: 5,
                  ),
                  user_details['firstname']
                      .toString()
                      .text
                      .xl2
                      .color(Color(0xff403b58))
                      .bold
                      .make(),
                  SizedBox(
                    width: 5,
                  ),
                  user_details['lastname']
                      .toString()
                      .text
                      .xl2
                      .color(Color(0xff403b58))
                      .bold
                      .make(),
                ],
              ),
              SizedBox(
                height: 12,
              ),
              DiscoverSmallCard(
                  title: "BUY",
                  subtitle: "you can buy items..",
                  width: 500,
                  onTap: () {
                    Get.to(() => BuyerScreen(user, user_details));
                  }),
              DiscoverSmallCard(
                  title: "SELL",
                  subtitle: "you can sell items..",
                  width: 500,
                  onTap: () {
                    Get.to(() => SellerScreen(
                        user, user_details, user_details['sellingitems'], {}));
                  }),
              DiscoverSmallCard(
                  title: "My Items",
                  subtitle: "your items..",
                  width: 500,
                  textsize: 23.5,
                  onTap: () {
                    Get.to(() => MySellingItems(
                        user, user_details, user_details['sellingitems']));
                  }),
              DiscoverSmallCard(
                  title: "My Orders",
                  subtitle: "your orders",
                  width: 500,
                  textsize: 21,
                  onTap: () {
                    Get.to(() => OrderListScreen(
                        user, user_details, user_details['orderslist']));
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
