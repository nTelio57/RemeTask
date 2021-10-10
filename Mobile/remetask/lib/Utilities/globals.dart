import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';

class LogoImage extends StatelessWidget {
  final double width, height;
  const LogoImage({
    Key? key,
    this.width = 100,
    this.height = 100
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

class Background extends StatelessWidget{
  final Color color;

  const Background({
    Key? key,
    this.color = kPrimaryColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return background();
  }

  Widget background()
  {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: color
    );
  }

}
