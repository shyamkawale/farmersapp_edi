import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Loading extends StatelessWidget {
  final container_color;
  final dynamic loadingtype;

  const Loading({required this.container_color, required this.loadingtype});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: container_color,
      child: Center(
        child: loadingtype,
      ),
    );
  }
}
