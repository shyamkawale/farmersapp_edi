import 'package:farmersapp_edi/screens/marketplace/components/buyer/buyer_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class ItemDetailsScreen extends StatefulWidget {
  final User user;
  final Map user_details;
  final dynamic orderslist;
  final Map item;
  const ItemDetailsScreen(
      this.user, this.user_details, this.orderslist, this.item);

  @override
  State<ItemDetailsScreen> createState() => _ItemDetailsScreenState(
      this.user, this.user_details, this.orderslist, this.item);
}

class _ItemDetailsScreenState extends State<ItemDetailsScreen> {
  User user;
  Map user_details;
  dynamic orderslist;
  Map item;
  _ItemDetailsScreenState(
      this.user, this.user_details, this.orderslist, this.item);
  final dbRef_items = FirebaseDatabase.instance.reference().child("Items");
  final dbRef_users = FirebaseDatabase.instance.reference().child("Users");
  final dbRef_orders = FirebaseDatabase.instance.reference().child("Orders");
  int quantity = 1;

  // late List orderslist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FirebaseDatabase.instance
        .reference()
        .child("Users")
        .child(user.uid.toString())
        .once()
        .then((DataSnapshot dataSnapshot) async {
      Map<dynamic, dynamic> map = Map.from(dataSnapshot.value);
      if (dataSnapshot.value != null) {
        print(map.toString());
        print("initstate: " + map['orderslist'].toString());
        setState(() {
          orderslist = map['orderslist'];
        });
      }
    });
  }

  Future<void> changesToSellerItem(int quantity) {
    String finalQuantity =
        (int.parse(item["itemquantity"]) - quantity).toString();
    return dbRef_items
        .child("item_" + item['sellerid'] + "_" + item['itemname'])
        .update({'itemquantity': finalQuantity});
  }

  Future<void> changesToBuyer(String date, String time) {
    orderslist = orderslist.toList();
    setState(() {
      orderslist.add("order_buyer" +
          user.uid +
          "_seller" +
          item['sellerid'] +
          "_" +
          item['itemname'] +
          "_" +
          date +
          "_" +
          time);
    });

    print("orderslist: " + orderslist.toString());
    VxToast.show(context,
        msg: "you have succesfully ordered this item",
        position: VxToastPosition.bottom);
    Navigator.pop(context);
    return dbRef_users.child(user.uid).update({'orderslist': orderslist});
  }

  Future<void> changesToOrderList(int quantity, String date, String time) {
    int totalPrice = quantity * int.parse(item['itemprice']);
    return dbRef_orders
        .child("order_buyer" +
            user.uid +
            "_seller" +
            item['sellerid'] +
            "_" +
            item['itemname'] +
            "_" +
            date +
            "_" +
            time)
        .set({
      'ordersellerid': item['sellerid'],
      'orderitemname': item['itemname'],
      'orderitemcategory': item['itemcategory'],
      'orderitemmrp': item['itemprice'],
      'orderitemquantity': quantity.toString(),
      'ordertotalprice': totalPrice.toString(),
      'orderitemimage': item['itemimage'],
      'orderdate': date,
      "ordertime": time,
      'ordershippingaddress': {
        "city": user_details["address"][0]["city"],
        "pincode": user_details["address"][0]["city"]
      }
    });
  }

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
                height: 612,
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ("Name: " + widget.item['itemname'].toString())
                                  .text
                                  .xl2
                                  .size(20)
                                  .make(),
                              SizedBox(height: 10),
                              // Description(product: product),
                              ("Category: " +
                                      widget.item['itemcategory'].toString())
                                  .text
                                  .xl2
                                  .size(20)
                                  .make(),
                              SizedBox(height: 10),
                              // CounterWithFavBtn(),
                              ("Available Quantity: " +
                                      widget.item['itemquantity'].toString())
                                  .text
                                  .xl2
                                  .size(20)
                                  .make(),
                              SizedBox(height: 10),
                              ("Price: ₹ " +
                                      widget.item['itemprice'].toString())
                                  .text
                                  .xl2
                                  .size(20)
                                  .make(),
                              SizedBox(height: 10),

                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  // CartCounter(),
                                  Row(
                                    children: [
                                      "Quantity: ".text.xl.bold.make(),
                                      DropdownButton(
                                        hint: Text(
                                            'Quantity'), // Not necessary for Option 1
                                        value: quantity,
                                        onChanged: (int? newValue) {
                                          setState(() {
                                            quantity = newValue!;
                                          });
                                        },
                                        items: List.generate(
                                            int.parse(
                                                widget.item['itemquantity']),
                                            (index) => index + 1).map((number) {
                                          return DropdownMenuItem(
                                            child: Center(
                                                child: new Text(
                                                    number.toString())),
                                            value: number,
                                          );
                                        }).toList(),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.all(8),
                                    height: 32,
                                    width: 32,
                                    decoration: BoxDecoration(
                                      color: Color(0xFFFF6464),
                                      shape: BoxShape.circle,
                                    ),
                                    child: SvgPicture.asset(
                                        "assets/icons/heart.svg"),
                                  )
                                ],
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Container(
                                color: Colors.yellow[50],
                                width: 200,
                                height: 45,
                                child: Center(
                                  child: (("₹" +
                                              (quantity *
                                                      int.parse(widget
                                                          .item['itemprice']))
                                                  .toString())
                                          .toString())
                                      .text
                                      .xl2
                                      .make(),
                                ),
                              ),
                              SizedBox(
                                width: 25,
                              ),
                              MaterialButton(
                                elevation: 5,
                                color: Colors.amber,
                                child: Text("Buy Now"),
                                onPressed: () {
                                  print(quantity.toString());
                                  String date = DateTime.now().day.toString() +
                                      "-" +
                                      DateTime.now().month.toString() +
                                      "-" +
                                      DateTime.now().year.toString();
                                  String time = DateTime.now().hour.toString() +
                                      ":" +
                                      DateTime.now().minute.toString() +
                                      ":" +
                                      DateTime.now().second.toString();
                                  changesToSellerItem(quantity);
                                  changesToOrderList(quantity, date, time);
                                  changesToBuyer(date, time);
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    ProductTitleWithImage(widget.item)
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

class ProductTitleWithImage extends StatelessWidget {
  Map item;
  ProductTitleWithImage(this.item);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 18),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Header(item),
          SizedBox(height: 5),
          Align(
              alignment: Alignment.center,
              child: Container(
                height: 155,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(24.0),
                    child: (item['itemimage'] == "")
                        ? Image.asset(
                            "assets/images/defaultitem.png",
                          )
                        : Image.network(
                            item['itemimage'],
                          )),
              )),
        ],
      ),
    );
  }
}

class Header extends StatelessWidget {
  Map item;
  Header(this.item);
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
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
              width: 180,
            ),
            IconButton(
              icon: SvgPicture.asset("assets/icons/search.svg"),
              onPressed: () {},
            ),
            IconButton(
              icon: SvgPicture.asset("assets/icons/cart.svg"),
              onPressed: () {},
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: 10,
            ),
            Text(
              item['itemname'],
              style: TextStyle(fontSize: 40),
            ),
          ],
        )
      ],
    );
  }
}

class CartCounter extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CartCounter> {
  int numOfItems = 1;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildOutlineButton(
          icon: Icons.remove,
          press: () {
            if (numOfItems > 1) {
              setState(() {
                numOfItems--;
              });
            }
          },
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            // if our item is less  then 10 then  it shows 01 02 like that
            numOfItems.toString().padLeft(2, "0"),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        buildOutlineButton(
            icon: Icons.add,
            press: () {
              setState(() {
                numOfItems++;
              });
            }),
      ],
    );
  }

  SizedBox buildOutlineButton(
      {required IconData icon, required Function press}) {
    return SizedBox(
      width: 40,
      height: 32,
      child: OutlineButton(
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(13),
        ),
        onPressed: () => press,
        child: Icon(icon),
      ),
    );
  }
}
