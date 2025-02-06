import 'package:flutter/material.dart';
import 'package:to_do_list/colors.dart';

class ThemeContainer extends StatelessWidget {
Color scafoldColor;
Color secondColor;
VoidCallback  onTap;
ThemeContainer({required this.scafoldColor ,
  required this.secondColor , required this.onTap});
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child:  Container(
        width: width*.3,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black)
        ),
        child: Column(
          children: [
            Container(
              height: height*.02,
              color: scafoldColor, // Top part color
            ),
            Container(
              height: height*.02, // Height of the line
              color:secondColor, // Line color
            ),
            Container(
              height: height*.08,
              color: scafoldColor, // Bottom part color
            ),
          ],
        ),
      ),
    );
  }
}
