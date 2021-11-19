import 'package:farmersapp_edi/screens/marketplace/components/buyer/item_details_screen.dart';
import 'package:farmersapp_edi/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class BuyerScreen extends StatefulWidget {
  final User user;
  final Map user_details;
  const BuyerScreen(this.user, this.user_details);
  @override
  _BuyerScreenState createState() =>
      _BuyerScreenState(this.user, this.user_details);
}

class _BuyerScreenState extends State<BuyerScreen> {
  User user;
  Map user_details;
  _BuyerScreenState(this.user, this.user_details);
  final dbRef_items = FirebaseDatabase.instance.reference().child("Items");
  final dbRef_users = FirebaseDatabase.instance.reference().child("Users");

  // late List orderslist;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // dbRef_users.child(user.uid).once().then((DataSnapshot dataSnapshot) async {
    //   Map<dynamic, dynamic> map = Map.from(dataSnapshot.value);
    //   if (dataSnapshot.value != null) {
    //     print("init state orderslist: " + map['orderslist']);
    //     setState(() {
    //       orderslist = map['orderslist'];
    //     });
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Header(),
              Expanded(
                  child: FutureBuilder(
                      future: dbRef_items.once(),
                      builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                        if (snapshot.hasData) {
                          Map<dynamic, dynamic> itemsmap =
                              Map.from(snapshot.data!.value);
                          List itemsmapkeys = itemsmap.keys.toList();
                          print(itemsmap);
                          print(itemsmapkeys);
                          return CatalogList(user, user_details, itemsmap,
                              user_details['orderslist'], itemsmapkeys);
                        }
                        return Center(
                            child: SpinKitCircle(
                          color: Colors.green,
                          size: 90,
                        ));
                      })),
            ],
          ),
        ),
      ),
    );
  }
}

class CatalogList extends StatefulWidget {
  final User user;
  final Map user_details;
  Map itemsmap;
  final List orderslist;
  List itemsmapkeys;
  CatalogList(this.user, this.user_details, this.itemsmap, this.orderslist,
      this.itemsmapkeys);

  @override
  State<CatalogList> createState() => _CatalogListState();
}

class _CatalogListState extends State<CatalogList> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      controller: _refreshController,
      enablePullDown: true,
      enablePullUp: true,
      onRefresh: () async {
        await FirebaseDatabase.instance
            .reference()
            .child("Items")
            .once()
            .then((DataSnapshot dataSnapshot) async {
          Map<dynamic, dynamic> map = Map.from(dataSnapshot.value);
          if (dataSnapshot.value != null) {
            setState(() {
              widget.itemsmap = map;
              widget.itemsmapkeys = map.keys.toList();
            });
          }
          if (mounted) setState(() {});
          _refreshController.refreshCompleted();
        });
      },
      child: ListView.builder(
        itemCount: widget.itemsmap.length,
        itemBuilder: (context, index) {
          if (!widget.itemsmapkeys[index]
              .toString()
              .contains(widget.user.uid)) {
            if (int.parse(widget.itemsmap[widget.itemsmapkeys[index]]
                    ['itemquantity']) >
                0) {
              return CatalogItem(
                  widget.user,
                  widget.user_details,
                  widget.orderslist,
                  widget.itemsmap[widget.itemsmapkeys[index]]);
            } else {
              return Container();
            }
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class CatalogItem extends StatelessWidget {
  final User user;
  final Map user_details;
  final List orderslist;
  final Map item;
  CatalogItem(this.user, this.user_details, this.orderslist, this.item);

  @override
  Widget build(BuildContext context) {
    return VxBox(
        child: Row(
      children: [
        CatalogImage(item['itemimage']),
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            item['itemname']
                .toString()
                .text
                .lg
                .color(Color(0xff403b58))
                .bold
                .make(),
            item['itemcategory'].toString().text.make(),
            10.heightBox,
            ButtonBar(
              alignment: MainAxisAlignment.end,
              buttonPadding: EdgeInsets.zero,
              children: [
                "₹".text.bold.xl2.make(),
                item['itemprice'].toString().text.bold.xl2.make(),
                SizedBox(
                  width: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.to(() => ItemDetailsScreen(
                        user, user_details, orderslist, item));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                        Color(0xff403b58),
                      ),
                      shape: MaterialStateProperty.all(
                        StadiumBorder(),
                      )),
                  child: "Description".text.make(),
                )
              ],
            ).pOnly(right: 8.0)
          ],
        ))
      ],
    )).white.rounded.square(120).make().py8();
  }
}

class CatalogImage extends StatelessWidget {
  String itemimage;
  CatalogImage(this.itemimage);

  @override
  Widget build(BuildContext context) {
    return (itemimage == "")
        ? Image.asset(
            "assets/images/defaultitem.png",
            fit: BoxFit.fill,
          ).box.rounded.p8.color(Color(0xfff5f5f5)).make().p16().w40(context)
        : Image.network(
            itemimage,
            fit: BoxFit.fill,
          ).box.rounded.p8.color(Color(0xfff5f5f5)).make().p16().w40(context);
  }
}

class Header extends StatelessWidget {
  const Header({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        "Catalog".text.xl5.bold.make(),
      ],
    );
  }
}
