import 'package:farmersapp_edi/components/text_field_container.dart';
import 'package:farmersapp_edi/constants.dart';
import 'package:farmersapp_edi/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';
//import 'dart:math';
//import 'package:math_expressions/math_expressions.dart';

class PredModel extends StatefulWidget {
  @override
  _PredModelState createState() => _PredModelState();
}

class _PredModelState extends State<PredModel> {
  var predValue = "";
  @override
  void initState() {
    super.initState();
    predValue = "click predict button";
  }

  final N_Controller = TextEditingController();
  final P_Controller = TextEditingController();
  final K_Controller = TextEditingController();
  // final Temp_Controller = TextEditingController();              //del
  // final Humidity_Controller = TextEditingController();          //del
  final Ph_Controller = TextEditingController();
  final Rain_Controller = TextEditingController(); //del
  final City_Controller = TextEditingController();

  var Temp_api;
  var Humidity_api;

  Future<void> predData() async {
    //String strr
    final interpreter = await Interpreter.fromAsset('ml_model.tflite');
    //var input = [ [90.0,42.0,43.0,20.0,82.0,6.0,202.0] ];
    var N_ = double.parse(N_Controller.text);
    var P_ = double.parse(P_Controller.text);
    var K_ = double.parse(K_Controller.text);
    //var Temp_ = double.parse(Temp_Controller.text);
    //var Humidity_ = double.parse(Humidity_Controller.text);
    var Ph_ = double.parse(Ph_Controller.text);
    var Rain_ = double.parse(Rain_Controller.text);
    var City_ = City_Controller.text;

    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=" +
            City_.toString() +
            "&units=metric&appid=e43ac111fdcd8670e101cf9d0f9c7749")); // any way this is secret
    var results = jsonDecode(response.body);
    // setState ((){
    //   this.Temp_api=results['main']['temp'];
    //   this.Humidity_api=results['main']['humidity'];
    // });

    Temp_api = results['main']['temp'];
    Humidity_api = results['main']['humidity'];

    print("This is what I wanted below");
    print(Temp_api.toString());
    print(Humidity_api.toString());

    var Temp_ = double.parse(Temp_api.toString());
    var Humidity_ = double.parse(Humidity_api.toString());
    print(Temp_.toString() + " Temp_");
    print(Humidity_.toString() + " Humidity_");

    //var input = [ [ N_Controller.text, P_Controller.text, K_Controller.text, Temp_Controller.text, Humidity_Controller.text, Ph_Controller.text, Rain_Controller.text       ]  ];
    //var input =[[  onePointOne,onePointOne,onePointOne,onePointOne,onePointOne,onePointOne,onePointOne  ]];
    //print(strr);
    var input = [
      [N_, P_, K_, Temp_, Humidity_, Ph_, Rain_]
    ];

    print('THis is controllers input');
    print(N_Controller.text + ' N_Controller.text');
    print(P_Controller.text + ' P_Controller.text');
    print(K_Controller.text + ' K_Controller.text');
    // print(  Temp_Controller.text + ' Temp_Controller.text');
    // print(  Humidity_Controller.text + ' Humidity_Controller.text');
    print(Ph_Controller.text + ' Ph_Controller.text');
    print(Rain_Controller.text + ' Rain_Controller.text');
    print(City_Controller.text + ' City_Controller.text');

    var output = List.filled(22, 0).reshape([1, 22]);
    interpreter.run(input, output);
    //print(output);
    print(output[0]);
    print(output[0][0]);
    //print(output[0].reduce(max));

    var x = 0;
    var maax = output[0][0];
    var index = 0;
    for (x; x < 22; x++) {
      if (output[0][x] > maax) {
        maax = output[0][x];
        index = x;
      }
    }
    print(maax);
    print(index);

    this.setState(() {
      //predValue = "abhi";//index.toString();//output[0][0].toString();
      if (index == 0) predValue = 'Apple';
      if (index == 1) predValue = 'Banana';
      if (index == 2) predValue = 'Black Gram';
      if (index == 3) predValue = 'Chickapea';
      if (index == 4) predValue = 'Coconut';
      if (index == 5) predValue = 'Coffee';
      if (index == 6) predValue = 'Cotton';
      if (index == 7) predValue = 'Grapes';
      if (index == 8) predValue = 'Jute';
      if (index == 9) predValue = 'kidneybeans';
      if (index == 10) predValue = 'Lentil';
      if (index == 11) predValue = 'Maize';
      if (index == 12) predValue = 'Mango';
      if (index == 13) predValue = 'mothbeans';
      if (index == 14) predValue = 'mungbean';
      if (index == 15) predValue = 'Muskmelon';
      if (index == 16) predValue = 'Orange';
      if (index == 17) predValue = 'Papaya';
      if (index == 18) predValue = 'pigeonpeas';
      if (index == 19) predValue = 'Pomegranate';
      if (index == 20) predValue = 'Rice';
      if (index == 21) predValue = 'Watermelon';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar("Crop prediction"),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 5),
                Align(
                  alignment: Alignment.centerLeft,
                  child: "    Add your soil details".text.xl.make(),
                ),
                SizedBox(height: 5),
                TextFieldContainer(
                  child: TextField(
                    keyboardType: TextInputType.number,
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.photo_camera_front_outlined,
                        color: kPrimaryColor,
                      ),
                      labelText: "Nitrogen Content",
                      hintText: "PLEASE ENTER Nitrogen content",
                      border: InputBorder.none,
                    ),
                    controller: N_Controller,
                  ),
                ),
                SizedBox(height: 2),
                TextFieldContainer(
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.photo_camera_front_outlined,
                        color: kPrimaryColor,
                      ),
                      labelText: "Phosphorus Content",
                      hintText: "PLEASE ENTER Phosphorus Content",
                      border: InputBorder.none,
                    ),
                    controller: P_Controller,
                  ),
                ),
                SizedBox(height: 2),
                TextFieldContainer(
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.photo_camera_front_outlined,
                        color: kPrimaryColor,
                      ),
                      labelText: "Potassium Content",
                      hintText: "PLEASE ENTER Potassium Content",
                      border: InputBorder.none,
                    ),
                    controller: K_Controller,
                  ),
                ),
                SizedBox(height: 2),

                // TextField(                                           // Temp
                //   controller: Temp_Controller,
                //   keyboardType: TextInputType.number,
                //   textAlign: TextAlign.left,
                //   decoration: InputDecoration(
                //     border: InputBorder.none,
                //     hintText: 'PLEASE ENTER Temprature',
                //     hintStyle: TextStyle(color: Colors.grey),
                //   ),
                // ),

                // TextField(                                            // Humidity
                //   controller: Humidity_Controller,
                //   keyboardType: TextInputType.number,
                //   textAlign: TextAlign.left,
                //   decoration: InputDecoration(
                //     border: InputBorder.none,
                //     hintText: 'PLEASE ENTER Humidity Content',
                //     hintStyle: TextStyle(color: Colors.grey),
                //   ),
                // ),

                TextFieldContainer(
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.photo_camera_front_outlined,
                        color: kPrimaryColor,
                      ),
                      labelText: "Ph value between 0 to 7",
                      hintText: "PLEASE ENTER Ph value",
                      border: InputBorder.none,
                    ),
                    controller: Ph_Controller,
                  ),
                ),
                SizedBox(height: 2),
                TextFieldContainer(
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.photo_camera_front_outlined,
                        color: kPrimaryColor,
                      ),
                      labelText: "Rain Content",
                      hintText: "PLEASE ENTER Rain Content",
                      border: InputBorder.none,
                    ),
                    controller: Rain_Controller,
                  ),
                ),
                SizedBox(height: 2),
                TextFieldContainer(
                  child: TextField(
                    cursorColor: kPrimaryColor,
                    decoration: InputDecoration(
                      icon: Icon(
                        Icons.photo_camera_front_outlined,
                        color: kPrimaryColor,
                      ),
                      labelText: "City",
                      hintText:
                          "PLEASE ENTER City (Temp, Humidity feteched by API)",
                      border: InputBorder.none,
                    ),
                    controller: City_Controller,
                  ),
                ),
                SizedBox(height: 2),

                // Text(
                //   "change the input values in code to get the prediction",
                //   style: TextStyle(fontSize: 16),
                // ),

                SizedBox(height: 12),
                MaterialButton(
                  color: Colors.blue,
                  child: Text(
                    "predict",
                    style: TextStyle(fontSize: 25),
                  ),

                  onPressed: predData,
                  //onPressed: () {
                  //  predData( 'abhi' );
                  //},
                ),
                SizedBox(height: 12),
                Text(
                  "Predicted value :  $predValue ",
                  style: TextStyle(color: Colors.red, fontSize: 23),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
