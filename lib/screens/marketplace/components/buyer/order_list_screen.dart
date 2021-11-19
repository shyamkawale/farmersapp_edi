import 'package:farmersapp_edi/screens/marketplace/components/buyer/order_details_screen.dart';
import 'package:farmersapp_edi/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderListScreen extends StatefulWidget {
  final User user;
  final Map user_details;
  final List orderslist;

  const OrderListScreen(this.user, this.user_details, this.orderslist);

  @override
  _OrderListScreenState createState() =>
      _OrderListScreenState(this.user, this.user_details, this.orderslist);
}

class _OrderListScreenState extends State<OrderListScreen> {
  final User user;
  final Map user_details;
  final List orderslist;
  _OrderListScreenState(this.user, this.user_details, this.orderslist);
  final dbRef_orders = FirebaseDatabase.instance.reference().child("Orders");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Your Orders"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Expanded(
                child: FutureBuilder(
                    future: dbRef_orders.once(),
                    builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                      if (snapshot.hasData) {
                        Map<dynamic, dynamic> ordersmap =
                            Map.from(snapshot.data!.value);
                        List ordersmapkeys = ordersmap.keys.toList();
                        print(ordersmap);
                        print(ordersmapkeys);
                        // return Text(ordersmap.toString());
                        return ListView.builder(
                          itemCount: ordersmap.length,
                          itemBuilder: (context, index) {
                            if (ordersmapkeys[index]
                                .toString()
                                .contains(user.uid)) {
                              return OrderDesign(user, user_details,
                                  ordersmap[ordersmapkeys[index]]);
                            } else {
                              return Container();
                            }
                          },
                        );
                      }
                      return Center(
                          child: SpinKitCircle(
                        color: Colors.green,
                        size: 90,
                      ));
                    }))
          ],
        ),
      ),
    );
  }
}

class OrderDesign extends StatelessWidget {
  final User user;
  final Map user_details;
  Map order;
  OrderDesign(this.user, this.user_details, this.order);
  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        OrderImage(order['orderitemimage']),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            order['orderitemname']
                .toString()
                .text
                .lg
                .color(Color(0xff403b58))
                .bold
                .make(),
            order['orderitemcategory'].toString().text.make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.zero,
              children: [
                "₹".text.bold.xl2.make(),
                order['ordertotalprice'].toString().text.bold.xl3.make(),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    ("Date: " + order['orderdate'].toString())
                        .toString()
                        .text
                        .lg
                        .make(),
                    ("Quantity: " + order['orderitemquantity'].toString())
                        .toString()
                        .text
                        .lg
                        .make(),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() =>
                            OrderDetailsScreen(user, user_details, order));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xff403b58),
                          ),
                          shape: MaterialStateProperty.all(
                            StadiumBorder(),
                          )),
                      child: "Order Details".text.make(),
                    ),
                  ],
                )
              ],
            ).pOnly(right: 8.0)
          ],
        ))
      ],
    )).white.rounded.square(130).make().py8();
  }
}

class OrderImage extends StatelessWidget {
  String orderimage;
  OrderImage(this.orderimage);

  @override
  Widget build(BuildContext context) {
    return (orderimage == "")
        ? Image.asset(
            "assets/icons/orders.png",
            fit: BoxFit.fill,
          ).box.rounded.p8.color(Color(0xfff5f5f5)).make().p12().w40(context)
        : Image.network(
            orderimage,
            fit: BoxFit.fill,
          ).box.rounded.p8.color(Color(0xfff5f5f5)).make().p12().w40(context);
  }
}
