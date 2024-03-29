import 'package:eauc/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class ShadedContainer extends StatelessWidget {
  // ShadedContainer({required this.theTitle,required this.theRoute,required this.imgName,required this.theIcon});
  ShadedContainer({required this.theTitle, required this.theRoute, required this.imgName});

  final String theTitle;
  final String imgName;
  final String theRoute;

  // final Icon theIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.width*0.35,
      // width: MediaQuery.of(context).size.width*0.30,
      padding: EdgeInsets.all(5),
      height: 150,
      width: 160,
      margin: EdgeInsets.all(5),
      // padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            offset: Offset(0.0, 1.0), //(x,y)
            blurRadius: 10.0,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                image: DecorationImage(
                  image: AssetImage(
                    'assets/images/' + imgName + '.jpg',
                  ),
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Flexible(
            flex: 1,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                theTitle,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: ksecondarycolor,
                    fontSize: 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
