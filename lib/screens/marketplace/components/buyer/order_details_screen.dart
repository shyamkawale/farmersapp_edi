import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocity_x/velocity_x.dart';

class OrderDetailsScreen extends StatefulWidget {
  final User user;
  final Map user_details;
  final Map order;

  const OrderDetailsScreen(this.user, this.user_details, this.order);
  @override
  _OrderDetailsScreenState createState() =>
      _OrderDetailsScreenState(this.user, this.user_details, this.order);
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  User user;
  Map user_details;
  Map order;
  _OrderDetailsScreenState(this.user, this.user_details, this.order);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white70,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 800,
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.only(top: size.height * 0.42),
                      padding: EdgeInsets.only(
                          top: size.height * 0.03,
                          left: 20,
                          right: 20,
                          bottom: 25),
                      width: size.width,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(24),
                          topRight: Radius.circular(24),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ("Name: " + order['orderitemname'])
                                    .toString()
                                    .text
                                    .xl
                                    .size(15)
                                    .make(),
                                SizedBox(height: 10),
                                // Description(product: product),
                                ("Category: " + order['orderitemcategory'])
                                    .toString()
                                    .text
                                    .xl
                                    .size(15)
                                    .make(),
                                SizedBox(height: 10),
                                // CounterWithFavBtn(),
                                ("Quantity: " + order['orderitemquantity'])
                                    .toString()
                                    .text
                                    .xl
                                    .size(15)
                                    .make(),
                                SizedBox(height: 10),
                                ("Price of each item: ₹ " +
                                        order['orderitemmrp'])
                                    .toString()
                                    .text
                                    .xl
                                    .size(15)
                                    .make(),
                                SizedBox(height: 10),
                                ("Total Price: ₹ " + order['ordertotalprice'])
                                    .toString()
                                    .text
                                    .xl
                                    .size(15)
                                    .make(),
                                SizedBox(height: 10),
                                ("Date of Order: " + order['orderdate'])
                                    .toString()
                                    .text
                                    .xl
                                    .size(15)
                                    .make(),
                                SizedBox(height: 10),
                                ("Time of Order: " + order['ordertime'])
                                    .toString()
                                    .text
                                    .xl
                                    .size(15)
                                    .make(),
                                SizedBox(height: 10),
                                ("Seller id: " + order['ordersellerid'])
                                    .toString()
                                    .text
                                    .xl
                                    .size(15)
                                    .make(),
                                SizedBox(height: 10),
                                // Container(
                                //   padding: EdgeInsets.all(8),
                                //   height: 32,
                                //   width: 32,
                                //   decoration: BoxDecoration(
                                //     color: Color(0xFFFF6464),
                                //     shape: BoxShape.circle,
                                //   ),
                                //   child: SvgPicture.asset(
                                //       "assets/icons/heart.svg"),
                                // )
                                SizedBox(height: 100),
                              ],
                            ),
                          ],
                        ),
                      ),

                      // ],
                      // ),
                    ),
                    OrderTitleWithImage(order)
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class OrderTitleWithImage extends StatelessWidget {
  Map order;
  OrderTitleWithImage(this.order);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(order),
          SizedBox(height: 5),
          Align(
              alignment: Alignment.center,
              child: Container(
                height: 155,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: (order['orderitemimage'] == "")
                        ? Image.asset(
                            "assets/images/defaultitem.png",
                          )
                        : Image.network(
                            order['orderitemimage'],
                          )),
              )),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  Map order;
  Header(this.order);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        SizedBox(
          height: 7,
        ),
        Row(
          children: [
            Container(
              height: 30,
              width: 30,
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.all(Radius.circular(25))),
              child: IconButton(
                icon: SvgPicture.asset(
                  'assets/icons/Back ICon.svg',
                  color: Colors.white,
                ),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            SizedBox(
              width: 250,
            ),
            Container(
              padding: EdgeInsets.all(8),
              height: 35,
              width: 35,
              decoration: BoxDecoration(
                color: Color(0xFFFF6464),
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset("assets/icons/heart.svg"),
            )
            // IconButton(
            //   icon: SvgPicture.asset("assets/icons/search.svg"),
            //   onPressed: () {},
            // ),
            // IconButton(
            //   icon: SvgPicture.asset("assets/icons/cart.svg"),
            //   onPressed: () {},
            // ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              order['orderitemname'],
              style: TextStyle(fontSize: 40),
            ),
          ],
        )
      ],
    );
  }
}
