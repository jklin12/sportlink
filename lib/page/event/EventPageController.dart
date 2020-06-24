import 'package:flutter/material.dart';
import 'package:sportlink_demo/page/event/EventHomePage.dart';
import 'package:sportlink_demo/page/event/EventNotificationPage.dart';
import 'package:sportlink_demo/page/event/EventTimelinePage.dart';

class EventPageController extends StatefulWidget {
  EventPageController({this.enevtid, this.title});
  final String enevtid;
  final String title;
  @override
  _EventPageControllerState createState() => _EventPageControllerState();
}

class _EventPageControllerState extends State<EventPageController>
    with SingleTickerProviderStateMixin {
  TabController controller;

  @override
  void initState() {
    controller = new TabController(vsync: this, length: 3);
    //tambahkan SingleTickerProviderStateMikin pada class _HomeState
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black),
        ),
        actions: <Widget>[
          IconButton(
            icon: new Icon(
              Icons.close,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(null),
          ),
        ],
        leading: Container(),
      ),
      body: Column(
        // Column
        children: <Widget>[
          Container(
            color: Color(0XFF000000), // Tab Bar color change
            child: TabBar(
              // TabBar
              controller: controller,
              unselectedLabelColor: Colors.white,
              indicator: BoxDecoration(
                color: Color(0XFF242424),
              ),
              tabs: <Widget>[
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.history)),
                Tab(icon: Icon(Icons.notifications)),
              ],
            ),
          ),
          Expanded(
            flex: 3,
            child: TabBarView(
              // Tab Bar View
              physics: BouncingScrollPhysics(),
              controller: controller,
              children: <Widget>[
                EventHomePage(
                  enevtid: widget.enevtid,
                  title: widget.title,
                ),
                EventTimelinePage(),
                EventNotificationPage()
              ],
            ),
          ),
        ],
      ),
    );
  }
}
