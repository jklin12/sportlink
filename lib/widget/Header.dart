import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  Header({this.title, this.mycolor, this.textcolor});
  final String title;
  final int mycolor;
  final int textcolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40.0,
      width: MediaQuery.of(context).size.width,
      color: Color(mycolor),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          title,
          style: TextStyle(
              color: Color(textcolor),
              fontSize: 20.0,
              fontWeight: FontWeight.w700),
        ),
      ),
    );
  }
}
