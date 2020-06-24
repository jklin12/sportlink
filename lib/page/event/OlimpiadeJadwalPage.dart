import 'package:flutter/material.dart';
import 'package:group_list_view/group_list_view.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:sportlink_demo/bloc/BlocJadwalOlimpiade.dart';

class OlimpiadeJadwalPage extends StatefulWidget {
  OlimpiadeJadwalPage({this.eventid});
  final String eventid;
  @override
  _OlimpiadeJadwalPageState createState() => _OlimpiadeJadwalPageState();
}

Map<String, List> _elements = {
  'Team A': ['Klay Lewis', 'Ehsan Woodard', 'River Bains'],
  'Team B': ['Toyah Downs', 'Tyla Kane'],
  'Team C': ['Marcus Romero', 'Farrah Parkes', 'Fay Lawson', 'Asif Mckay'],
  'Team D': [
    'Casey Zuniga',
    'Ayisha Burn',
    'Josie Hayden',
    'Kenan Walls',
    'Mario Powers'
  ],
  'Team Q': ['Toyah Downs', 'Tyla Kane', 'Toyah Downs'],
};

class _OlimpiadeJadwalPageState extends State<OlimpiadeJadwalPage> {
  @override
  Widget build(BuildContext context) {
    final BlocJadwalOlimpiade blocjadwal =
        Provider.of<BlocJadwalOlimpiade>(context);
    //blocjadwal.fetchjadwal(widget.eventid);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "JADWAL PERTANDINGAN",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.white,
          leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.pop(context);
              })),
      body: SingleChildScrollView(
          child: blocjadwal == null
              ? Container(
                  height: 250.0,
                  child: Center(child: CircularProgressIndicator()),
                )
              : Container(
                  width: MediaQuery.of(context).size.width,
                  height: 250.0,
                  child: GroupListView(
                    sectionsCount: _elements.keys.toList().length,
                    countOfItemInSection: (int section) {
                      return _elements.values.toList()[section].length;
                    },
                    itemBuilder: (BuildContext context, IndexPath index) {
                      return Text(
                        _elements.values.toList()[index.section][index.index],
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      );
                    },
                    groupHeaderBuilder: (BuildContext context, int section) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 8),
                        child: Text(
                          _elements.keys.toList()[section],
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) => SizedBox(height: 10),
                  ),
                )),
    );
  }
}
