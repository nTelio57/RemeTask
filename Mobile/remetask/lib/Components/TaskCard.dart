import 'package:flutter/material.dart';
import 'package:remetask/Utilities/constants.dart';

class TaskCard extends StatelessWidget {

  final String title, tag, time, timeType;
  final Color color, fontColor;
  const TaskCard({
    Key? key,
    this.title = 'Very long title',
    this.tag = 'TAG',
    this.time = '4',
    this.timeType = 'days',
    this.color = kTaskGood,
    this.fontColor = kTextOnPrimary
  }) : super(key: key);

  final double _borderRadius = 8;

  @override
  Widget build(BuildContext context) {
    return taskCard();
  }

  Widget taskCard()
  {
    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: Card(
          elevation: 0,
          color: Colors.white,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(_borderRadius),
          ),
          child: InkWell(
            splashColor: kPrimaryDarkColor.withAlpha(50),
            onTap: () {
              print('Card tapped');
            },
            borderRadius: BorderRadius.circular(_borderRadius),
            child: Container(
              width: double.infinity,
              height: 75,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 10, top: 7, right: 2),
                            child: Container(
                              child: Text(
                                title,
                                style: kTaskCardTitle,
                                textAlign: TextAlign.left,
                              ),
                              alignment: Alignment.centerLeft,
                              height: 25,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:const EdgeInsets.only(left: 10, right: 2, bottom: 7),
                            child: Container(
                              alignment: Alignment.bottomLeft,
                              height: 25,
                              child: Text(
                                tag,
                                style: kTaskCardTag,
                                textAlign: TextAlign.left,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.only(topRight: Radius.circular(_borderRadius), bottomRight: Radius.circular(_borderRadius)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              height: 38,
                              child: Text(
                                time,
                                style: kTaskCardTime,
                              ),
                            ),
                            Container(
                              child: Text(
                                timeType,
                                style: kTaskCardTimeType,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
