// import 'dart:io';

// import 'package:farmersapp_edi/components/rounded_button.dart';
// import 'package:farmersapp_edi/components/text_field_container.dart';
// import 'package:farmersapp_edi/constants.dart';
// import 'package:farmersapp_edi/theme.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_database/firebase_database.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path/path.dart';
// import 'package:velocity_x/velocity_x.dart';

// class UpdateItemScreen extends StatefulWidget {
//   final User user;
//   final Map user_details;
//   final List sellingitems;
//   final Map itemdetails;
//   const UpdateItemScreen(
//       this.user, this.user_details, this.sellingitems, this.itemdetails);
//   @override
//   _UpdateItemScreenState createState() => _UpdateItemScreenState(
//       this.user, this.user_details, this.sellingitems, this.itemdetails);
// }

// class _SellerScreenState extends State<UpdateItemScreen> {
//   User user;
//   Map user_details;
//   List sellingitems;
//   Map itemdetails;
//   _SellerScreenState(
//       this.user, this.user_details, this.sellingitems, this.itemdetails);
//   final dbRef_items = FirebaseDatabase.instance.reference().child("Items");
//   final dbRef_users = FirebaseDatabase.instance.reference().child("Users");
//   TextEditingController controllerItemName = TextEditingController();
//   TextEditingController controllerItemPrice = TextEditingController();
//   TextEditingController controllerItemQuantity = TextEditingController();
//   TextEditingController controllerItemCategory = TextEditingController();
//   // TextEditingController controllerAddress = TextEditingController
//   int itemno = 0;
//   final ImagePicker _picker = ImagePicker();
//   late XFile _image;
//   String itemimagepath = "";

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     dbRef_items.once().then((DataSnapshot dataSnapshot) async {
//       Map<dynamic, dynamic> map = Map.from(dataSnapshot.value);
//       if (dataSnapshot.value != null) {
//         print(map.toString());
//         setState(() {
//           itemno = map.length;
//         });
//       }
//     });
//     if (itemdetails.length != 0) {
//       controllerItemName.text = itemdetails['itemname'];
//       controllerItemPrice.text = itemdetails['itemprice'];
//       controllerItemQuantity.text = itemdetails['itemquantity'];
//       controllerItemCategory.text = itemdetails['itemcategory'];
//       itemimagepath = itemdetails['itemimage'];
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     Future uploadImage(BuildContext context) async {
//       String fileName = basename(_image.path);
//       File file = File(_image.path);
//       try {
//         await FirebaseStorage.instance
//             .ref()
//             .child("/items")
//             .child(fileName)
//             .putFile(file);
//         String downloadlink = await FirebaseStorage.instance
//             .ref()
//             .child("/items")
//             .child(fileName)
//             .getDownloadURL();
//         setState(() {
//           itemimagepath = downloadlink;
//           print("new file path: " + itemimagepath);
//         });
//       } on FirebaseException catch (e) {
//         // e.g, e.code == 'canceled'
//         print("image uploading crash");
//       }
//     }

//     Future getImageGallery() async {
//       XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       setState(() {
//         _image = image!;
//         print('Image Path: ' + _image.path);
//       });
//       uploadImage(context);
//     }

//     Future<void> additemdetails() {
//       return dbRef_items
//           .child("item_" + user.uid + "_" + controllerItemName.text)
//           .set({
//         'sellerid': user.uid,
//         'itemname': controllerItemName.text,
//         'itemprice': controllerItemPrice.text,
//         'itemquantity': controllerItemQuantity.text,
//         'itemcategory': controllerItemCategory.text,
//         'itemimage': itemimagepath
//       });
//     }

//     Future<void> addImagetoUser() {
//       sellingitems = sellingitems.toList();
//       sellingitems.add("item_" + user.uid + "_" + controllerItemName.text);
//       print("sellingitems: " + sellingitems.toString());
//       return dbRef_users.child(user.uid).update({'sellingitems': sellingitems});
//     }

//     return Scaffold(
//       appBar: customAppBar("Sell"),
//       body: SafeArea(
//         child: SizedBox(
//           width: double.infinity,
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 20),
//             child: SingleChildScrollView(
//               child: Column(
//                 children: [
//                   SizedBox(height: 5),
//                   Text(
//                     (itemdetails.length == 0)
//                         ? "Enter new item details"
//                         : "Update your item details",
//                     style: headingStyle,
//                   ),
//                   SizedBox(height: 5),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Padding(padding: EdgeInsets.all(10)),
//                       Align(
//                         alignment: Alignment.center,
//                         child: CircleAvatar(
//                           radius: 50,
//                           backgroundColor: Colors.black45,
//                           child: ClipOval(
//                             child: new SizedBox(
//                                 width: 95.0,
//                                 height: 95.0,
//                                 child: (itemimagepath == "")
//                                     ? Image.asset(
//                                         "assets/images/defaultitem.png",
//                                         fit: BoxFit.fill,
//                                       )
//                                     : Image.network(
//                                         itemimagepath,
//                                         fit: BoxFit.fill,
//                                       )),
//                           ),
//                         ),
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(top: 30.0),
//                         child: IconButton(
//                           icon: Icon(
//                             Icons.camera_alt,
//                             size: 30.0,
//                           ),
//                           onPressed: () {
//                             getImageGallery();
//                           },
//                         ),
//                       ),
//                     ],
//                   ),
//                   TextFieldContainer(
//                     child: TextField(
//                       cursorColor: kPrimaryColor,
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.photo_camera_front_outlined,
//                           color: kPrimaryColor,
//                         ),
//                         labelText: "Item Name",
//                         hintText: "Item Name",
//                         border: InputBorder.none,
//                       ),
//                       controller: controllerItemName,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   TextFieldContainer(
//                     child: TextField(
//                       cursorColor: kPrimaryColor,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.photo_camera_front_outlined,
//                           color: kPrimaryColor,
//                         ),
//                         labelText: "M.R.P",
//                         hintText: "M.R.P",
//                         border: InputBorder.none,
//                       ),
//                       controller: controllerItemPrice,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   TextFieldContainer(
//                     child: TextField(
//                       cursorColor: kPrimaryColor,
//                       keyboardType: TextInputType.number,
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.photo_camera_front_outlined,
//                           color: kPrimaryColor,
//                         ),
//                         labelText: "Quantity",
//                         hintText: "Quantity",
//                         border: InputBorder.none,
//                       ),
//                       controller: controllerItemQuantity,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   TextFieldContainer(
//                     child: TextField(
//                       cursorColor: kPrimaryColor,
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.photo_camera_front_outlined,
//                           color: kPrimaryColor,
//                         ),
//                         labelText: "Category",
//                         hintText: "Category",
//                         border: InputBorder.none,
//                       ),
//                       controller: controllerItemCategory,
//                     ),
//                   ),
//                   SizedBox(height: 2),
//                   RoundedButton(
//                     text: "UPDATE/ADD DETAILS",
//                     // press: () => print(itemno),
//                     press: () {
//                       additemdetails();
//                       addImagetoUser();
//                       VxToast.show(context,
//                           msg: "you have succesfully added an item",
//                           position: VxToastPosition.bottom);
//                     },
//                   ),
//                   Text(
//                     "By continuing your confirm that you agree \nwith our Term and Condition",
//                     textAlign: TextAlign.center,
//                     style: Theme.of(context).textTheme.caption,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
