import 'package:farmersapp_edi/screens/marketplace/components/seller/seller_screeen.dart';
import 'package:farmersapp_edi/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:velocity_x/velocity_x.dart';

class MySellingItems extends StatefulWidget {
  final User user;
  final Map user_details;
  final List sellingitems;

  const MySellingItems(this.user, this.user_details, this.sellingitems);

  @override
  _MySellingItemsState createState() =>
      _MySellingItemsState(this.user, this.user_details, this.sellingitems);
}

class _MySellingItemsState extends State<MySellingItems> {
  User user;
  Map user_details;
  List sellingitems;
  _MySellingItemsState(this.user, this.user_details, this.sellingitems);
  final dbRef_items = FirebaseDatabase.instance.reference().child("Items");
  // RefreshController _refreshController =
  //     RefreshController(initialRefresh: false);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Your selling items"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10),
            ),
            Expanded(
              // child: SingleChildScrollView(
              //   physics: ScrollPhysics(),
              child: FutureBuilder(
                  future: dbRef_items.once(),
                  builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
                    if (snapshot.hasData) {
                      Map<dynamic, dynamic> itemsmap =
                          Map.from(snapshot.data!.value);
                      List itemsmapkeys = itemsmap.keys.toList();
                      print(itemsmap);
                      print(itemsmapkeys);
                      return CatalogList(
                          user, user_details, itemsmap, itemsmapkeys);
                      // return ListView.builder(
                      //   itemCount: itemsmap.length,
                      //   itemBuilder: (context, index) {
                      //     if (sellingitems.contains(itemsmapkeys[index])) {
                      //       return Padding(
                      //           padding: EdgeInsets.all(8.0),
                      //           child: ListTile(
                      //               leading: (itemsmap[itemsmapkeys[index]]
                      //                           ['itemimage'] ==
                      //                       "")
                      //                   ? Image.asset(
                      //                       "assets/images/defaultitem.png",
                      //                       fit: BoxFit.fill,
                      //                     )
                      //                   : Image.network(
                      //                       itemsmap[itemsmapkeys[index]]
                      //                           ['itemimage']),
                      //               title: Text(itemsmap[itemsmapkeys[index]]
                      //                   ["itemname"]),
                      //               subtitle: Divider(
                      //                 color: Colors.amber,
                      //               ),
                      //               onTap: () => Get.to(SellerScreen(
                      //                   user,
                      //                   user_details,
                      //                   user_details['sellingitems'],
                      //                   itemsmap[itemsmapkeys[index]]))));
                      //     } else {
                      //       return Container();
                      //     }
                      //   },
                      // );
                    }
                    return Center(
                        child: SpinKitCircle(
                      color: Colors.green,
                      size: 90,
                    ));
                  }),
            ),
            // ),
          ],
        ),
      ),
    );
  }
}

class CatalogList extends StatefulWidget {
  final User user;
  final Map user_details;
  Map itemsmap;
  List itemsmapkeys;
  CatalogList(this.user, this.user_details, this.itemsmap, this.itemsmapkeys);

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
          if (widget.itemsmapkeys[index].toString().contains(widget.user.uid) ==
              true) {
            print("userid: " + widget.user.uid);
            print("itemid: " + widget.itemsmapkeys[index].toString());
            return CatalogItem(widget.user, widget.user_details,
                widget.itemsmap[widget.itemsmapkeys[index]]);
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
  Map item;
  CatalogItem(this.user, this.user_details, this.item);

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
                item['itemprice'].toString().text.bold.xl3.make(),
                SizedBox(
                  width: 10,
                ),
                Column(
                  children: [
                    Row(
                      children: [
                        "No.of items: ".text.lg.make(),
                        item['itemquantity'].toString().text.lg.make(),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(() => SellerScreen(user, user_details,
                            user_details['sellingitems'], item));
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            Color(0xff403b58),
                          ),
                          shape: MaterialStateProperty.all(
                            StadiumBorder(),
                          )),
                      child: "Update Details".text.make(),
                    ),
                  ],
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
