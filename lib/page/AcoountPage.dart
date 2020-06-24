import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportlink_demo/bloc/BlocTimeline.dart';
import 'package:sportlink_demo/model/ModelTimeLine.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink_demo/page/LoginPage.dart';

class AccountPage extends StatefulWidget {
  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage>
    with SingleTickerProviderStateMixin {
  bool loading = false;
  TabController _controller;
  String userid;
  String avatar;
  String username;
  String baner;
  int value;

  void getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        userid = pref.getString("userid");
        value = pref.getInt("value");
      });
    }
  }

  _userinfo() async {
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
  }

  _timerinit() {
    setState(() {
      loading = true;
      getPref();
    });
    Future.delayed(Duration(milliseconds: 500), () {
      if (userid == null) {
        setState(() {
          loading = false;
        });
      } else {
        _userinfo();
      }
    });
  }

  _timer() {
    setState(() {
      loading = true;
    });
    Future.delayed(Duration(seconds: 1), () {
      _userinfo();
    });
  }

  @override
  void initState() {
    super.initState();
    _timerinit();
    _controller = new TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BlocTimeline bloc = Provider.of<BlocTimeline>(context);
    bloc.fetchtimeline(userid);
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          child: loading
              ? Container(child: Center(child: CircularProgressIndicator()))
              : ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: userid == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Silahkan Masuk Terlebih Dahulu",
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontWeight: FontWeight.w300,
                                      fontSize: 20.0),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Material(
                                  elevation: 5.0,
                                  borderRadius: BorderRadius.circular(30.0),
                                  color: Colors.red,
                                  child: MaterialButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => LoginPage()),
                                      ).then((value) {
                                        setState(() {
                                          getPref();
                                          _timer();
                                        });
                                      });
                                    },
                                    child: Text(
                                      "Masuk",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        : Column(
                            children: <Widget>[
                              Container(
                                  // A fixed-height child.
                                  height:
                                      MediaQuery.of(context).size.height / 4,
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(
                                            baner,
                                          ),
                                          fit: BoxFit.cover)),
                                  alignment: Alignment.center,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(avatar),
                                              fit: BoxFit.cover,
                                            ),
                                            shape: BoxShape.circle,
                                            color: Color(0xFFe0f2f1)),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          username,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white),
                                        ),
                                      )
                                    ],
                                  )),
                              Expanded(
                                // A flexible child that will grow to fit the viewport but
                                // still be at least as big as necessary to fit its contents.
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 50.0,
                                      color: Color(0XFFDDDDDD),
                                      alignment: Alignment.center,
                                      child: new TabBar(
                                        unselectedLabelColor: Colors.white,
                                        indicator:
                                            BoxDecoration(color: Colors.white),
                                        controller: _controller,
                                        tabs: [
                                          new Tab(
                                              child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.history,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  "TIMELINE",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )),
                                          new Tab(
                                              child: Container(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                                Icon(
                                                  Icons.info,
                                                  color: Colors.black,
                                                ),
                                                Text(
                                                  "INFO",
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                )
                                              ],
                                            ),
                                          )),
                                        ],
                                      ),
                                    ),
                                    new Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.27,
                                      child: new TabBarView(
                                        controller: _controller,
                                        children: <Widget>[
                                          bloc.listtimeline == null
                                              ? Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : new GridView.builder(
                                                  gridDelegate:
                                                      SliverGridDelegateWithFixedCrossAxisCount(
                                                          crossAxisCount: 3),
                                                  itemCount:
                                                      bloc.listtimeline.length,
                                                  itemBuilder:
                                                      (context, index) {
                                                    final ModelTimeline data =
                                                        bloc.listtimeline[
                                                            index];
                                                    return Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      decoration: BoxDecoration(
                                                        image: DecorationImage(
                                                          image: NetworkImage(
                                                              data.gambar),
                                                          fit: BoxFit.cover,
                                                        ),
                                                      ),
                                                    );
                                                  }),
                                          new Card(
                                            child: new ListTile(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
        );
      },
    );
  }
}
