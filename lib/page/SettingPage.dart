import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportlink_demo/widget/PageController.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  bool isSwitched = true;

  signOut() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      pref.setInt("value", null);
      pref.setInt("userid", null);
    Navigator.pushReplacement(
      context, MaterialPageRoute(builder: (BuildContext context) => PageCtrl()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height / 1.27,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildMenu("PERSONAL", Icons.person),
          _buildSubMenu("Edit Profile"),
          _buildSubMenu("Change Password"),
          InkWell(
            onTap: () {
              signOut();
              print("test");
            },
            child: _buildSubMenu("Sign Out"),
          ),
          _buildMenu("NOTIFIKASI", Icons.notifications),
          _buildSubMenunotifikasi("Live Streaming", isSwitched),
          _buildSubMenunotifikasi("Balasan Komentar", isSwitched),
          _buildSubMenunotifikasi("Olahraga Faforit", isSwitched),
          _buildSubMenunotifikasi("Berita", isSwitched),
          _buildMenu("INFO", Icons.info),
          _buildSubMenu("About"),
          _buildSubMenu("Bantuan"),
          _buildSubMenu("Term of Use"),
          _buildSubMenu("App Version"),
        ],
      ),
    );
  }

  _buildMenu(String title, IconData myicon) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
          child: Icon(
            myicon,
            size: 30,
          ),
        ),
        Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
      ],
    );
  }

  _buildSubMenu(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(45.0, 8.0, 8.0, 8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 15.0),
      ),
    );
  }

  _buildSubMenunotifikasi(String title, bool myvalue) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(45.0, 0.0, 8.0, 0.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title),
          Switch(
            value: myvalue,
            onChanged: (value) {
              setState(() {
                myvalue = value;
              });
            },
            activeTrackColor: Colors.lightBlueAccent,
            activeColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}
