import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';

class LogoImage extends StatelessWidget {
  final double width, height;
  const LogoImage({
    Key key,
    this.width,
    this.height
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return logo();
  }

  Widget logo(){
    return Container(
      width: width,
      height: height,
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                color: kSecondaryLightColor,
                borderRadius: BorderRadius.all(Radius.circular(width*0.25))
            ),
          ),
          Center(
            child: Container(
                width: width * 0.75,
                height: height * 0.75,
                child: Column(
                  children: [
                    Image.asset('assets/images/logo3.png')
                  ],
                )
            ),
          )
        ],
      ),
    );
  }
}
