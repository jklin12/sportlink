import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:sportlink_demo/page/AcoountPage.dart';
import 'package:sportlink_demo/page/TimeLinePage.dart';
import 'package:sportlink_demo/page/HomePage.dart';
import 'package:sportlink_demo/page/NotificationPage.dart';
import 'package:sportlink_demo/page/SettingPage.dart';
import 'package:http/http.dart' as http;

class PageCtrl extends StatefulWidget {
  @override
  _PageCtrlState createState() => _PageCtrlState();
}

class _PageCtrlState extends State<PageCtrl> {
  String userid;

  int value;

  void getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userid = pref.getString("userid");
      value = pref.getInt("value");
    });
  }

  /*_userinfo() async {
    setState(() {
      loading = true;
    });
    final response = await http.post(
        "http://202.169.224.10/api_sportlink/api.php",
        body: {"opsi": "userinfo", "userid": userid});
    final data = jsonDecode(response.body);
    final jsonusername = data['username'];
    final jsonavatar = data['avatar'];
    final jsonbaner = data['baner'];
    setState(() {
      username = jsonusername;
      avatar = jsonavatar;
      baner = jsonbaner;
    });
    print(username);
    print(avatar);
    print(baner);
    setState(() {
      loading = false;
    });
  }*/

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
    Future.delayed(const Duration(seconds: 1), () {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                child: Image.network(
                  "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7f/National_Sports_Committee_of_Indonesia_%28KONI%29_logo.svg/1200px-National_Sports_Committee_of_Indonesia_%28KONI%29_logo.svg.png",
                  width: 50.0,
                  height: 50.0,
                ),
              ),
              Container(
                child: Image.asset(
                  "assets/images/sportlink.png",
                  width: 200.0,
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Container(
              color: Color(0XFF000000),
              child: TabBar(
                unselectedLabelColor: Colors.white,
                indicator: BoxDecoration(
                  color: Color(0XFF242424),
                ),
                tabs: [
                  Tab(icon: Icon(Icons.home)),
                  Tab(icon: Icon(Icons.history)),
                  Tab(icon: Icon(Icons.notifications)),
                  Tab(icon: Icon(Icons.person)),
                  Tab(icon: Icon(Icons.settings)),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  HomePage(),
                  TimeLinepage(),
                  NotificationPage(),
                  AccountPage(),
                  SettingPage()
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
