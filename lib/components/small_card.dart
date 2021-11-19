import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:velocity_x/velocity_x.dart';

class DiscoverSmallCard extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final double? textsize;
  final Color? gradientStartColor;
  final Color? gradientEndColor;
  final double? height;
  final double? width;
  final Widget? vectorBottom;
  final Widget? vectorTop;
  final double? borderRadius;
  final Widget? icon;
  final dynamic onTap;
  const DiscoverSmallCard(
      {Key? key,
      this.title,
      this.subtitle,
      this.textsize,
      this.gradientStartColor,
      this.gradientEndColor,
      this.height,
      this.width,
      this.vectorBottom,
      this.vectorTop,
      this.borderRadius,
      this.icon,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () => onTap() ?? () {},
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                gradientStartColor ?? Color(0xffcfd8dc),
                gradientEndColor ?? Color(0xff90a4ae),
              ],
              begin: Alignment.bottomLeft,
              end: Alignment.topRight,
            ),
          ),
          child: Stack(
            children: [
              Container(
                height: 115,
                width: width,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox(
                  height: 115,
                  width: width,
                  child: Stack(
                    children: [
                      // SizedBox(
                      //   height: 125,
                      //   width: 150,
                      //   child: SvgPicture.asset("assets/icons/Hamburger.svg"),
                      // ),
                      // SizedBox(
                      //   child: SvgPicture.asset(
                      //     "assets/icons/Hamburger.svg",
                      //     height: 125,
                      //     width: 150,
                      //     fit: BoxFit.fitHeight,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 115,
                width: width,
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: SvgPicture.asset(
                          "assets/icons/Hamburger.svg",
                          height: 50,
                          width: 50,
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      Container(
                        width: 150,
                        child: Column(
                          children: [
                            title
                                .toString()
                                .text
                                .xl2
                                .color(Color(0xff403b58))
                                .bold
                                .size(textsize ?? 30)
                                .make(),
                            subtitle
                                .toString()
                                .text
                                .lg
                                .color(Color(0xff403b58))
                                .size(10)
                                .make(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
