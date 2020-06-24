import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportlink_demo/bloc/blocberitaevent.dart';
import 'package:sportlink_demo/model/ModelBerita.dart';
import 'package:sportlink_demo/page/DetailPage.dart';
import 'package:sportlink_demo/page/event/OlimpiadeJadwalPage.dart';
import 'package:sportlink_demo/page/event/OlimpiadeMedaliPage.dart';
import 'package:sportlink_demo/widget/Header.dart';

class OlimpiadePage extends StatefulWidget {
  OlimpiadePage({this.enevtid, this.title});
  final String enevtid;
  final String title;
  @override
  _OlimpiadePageState createState() => _OlimpiadePageState();
}

class _OlimpiadePageState extends State<OlimpiadePage> {
  @override
  Widget build(BuildContext context) {
    final BlocBeritaEvent blocBeritaEvent =
        Provider.of<BlocBeritaEvent>(context);
    blocBeritaEvent.fetchhighligt(widget.enevtid);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          widget.title,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700),
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
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            //berita start
            Header(
              title: "BERITA",
              mycolor: 0XFFFFFFFF,
              textcolor: 0XFF202020,
            ),
            blocBeritaEvent.listberita == null
                ? Container(
                    height: 260.0,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 260,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: blocBeritaEvent.listberita.length,
                        itemBuilder: (context, index) {
                          final ModelBerita data =
                              blocBeritaEvent.listberita[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailPage(
                                                judul: data.judul,
                                                gambar: data.gambar,
                                                tanggal: data.tanggal,
                                                pengirim: data.pengirim,
                                                isi: data.isi,
                                                kategori: data.kategori,
                                                level: data.level,
                                                vidio: data.vidio,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: 180.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(data.gambar),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 8.0, top: 8.0),
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    child: Text(
                                      data.judul,
                                      style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w400),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
            //berita end
            //menustart
            Header(
              title: "Menu",
              mycolor: 0XFFFFFFFF,
              textcolor: 0XFF202020,
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              height: 220.0,
              child: GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2,
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OlimpiadeMedaliPage(
                                  id: widget.enevtid,
                                  namaevent: widget.title,
                                )),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/medal.png",
                          width: 50.0,
                          height: 50.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Perolehan Medali",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => OlimpiadeJadwalPage(
                                  eventid: widget.enevtid,
                                )),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset(
                          "assets/images/globe.png",
                          width: 50.0,
                          height: 50.0,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Jadwal Pertandingan",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 15.0),
                          ),
                        )
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image.asset(
                        "assets/images/globe.png",
                        width: 50.0,
                        height: 50.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "Cabang Olahraga",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 15.0),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            //menu end
          ],
        ),
      ),
    );
  }
}
