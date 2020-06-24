import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:sportlink_demo/bloc/BlocJadwal.dart';
import 'package:sportlink_demo/bloc/BlocPemain.dart';
import 'package:sportlink_demo/bloc/blocberitaevent.dart';
import 'package:sportlink_demo/model/ModelBerita.dart';
import 'package:sportlink_demo/model/ModelJadwal.dart';
import 'package:sportlink_demo/model/ModelPemain.dart';
import 'package:sportlink_demo/page/DetailPage.dart';
import 'package:sportlink_demo/widget/Header.dart';

class EventHomePage extends StatefulWidget {
  EventHomePage({this.enevtid, this.title});
  final String enevtid;
  final String title;
  @override
  _EventHomePageState createState() => _EventHomePageState();
}

class _EventHomePageState extends State<EventHomePage> {
  @override
  Widget build(BuildContext context) {
    final BlocBeritaEvent blocBeritaEvent =
        Provider.of<BlocBeritaEvent>(context);
    final BlocPemain blocpemain = Provider.of<BlocPemain>(context);
    final BlocJadwal blocjadwal = Provider.of<BlocJadwal>(context);
    blocBeritaEvent.fetchhighligt(widget.enevtid);
    blocpemain.fetchpemain(widget.enevtid);
    blocjadwal.fetchjadwal(widget.enevtid);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // berita start
            Header(
              title: "Berita",
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
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  ),
            //berita end
            //pemain
            blocpemain.listpemain == null
                ? Container(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  )
                : Container(
                    height: 300,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.black,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Pemain",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 250.0,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: blocpemain.listpemain.length,
                            itemBuilder: (context, index) {
                              ModelPemain data = blocpemain.listpemain[index];
                              return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: GestureDetector(
                                  onTap: () {},
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.3,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.white),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                    image:
                                                        NetworkImage(data.foto),
                                                    fit: BoxFit.cover,
                                                  ),
                                                  shape: BoxShape.circle,
                                                  color: Color(0xFFe0f2f1)),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0),
                                              child: Text(
                                                data.asal,
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                data.nama,
                                                style: TextStyle(
                                                    fontSize: 15.0,
                                                    fontWeight:
                                                        FontWeight.w700),
                                              ),
                                            ),
                                          ],
                                        ),
                                        InkWell(
                                            onTap: () {},
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(3),
                                                  color: Color(0XFFF4E574)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  "LIKE",
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
            //end pmeain
            //start jadwal
            Header(
              title: "JADWAL PERTANDINGAN HAR ini",
              mycolor: 0XFFFFFFFF,
              textcolor: 0XFF202020,
            ),
            blocjadwal == null
                ? Container(
                    height: 250.0,
                    child: Center(child: CircularProgressIndicator()),
                  )
                : Container(
                    width: MediaQuery.of(context).size.width,
                    height: 250.0,
                    child: ListView.builder(
                        itemCount: blocjadwal.listjadwal.length,
                        itemBuilder: (context, index) {
                          final ModelJadwal data = blocjadwal.listjadwal[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Icon(Icons.date_range),
                                      Text(Jiffy(data.jadwal).format("EEEE") +
                                          " " +
                                          Jiffy(data.jadwal)
                                              .format("MMM do yy")),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(Icons.timelapse),
                                      ),
                                      Text(Jiffy(data.jadwal)
                                          .format("h:mm:ss a")),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Icon(Icons.location_on),
                                      ),
                                      Text(data.lokasi)
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(8.0),
                                  height: 1.0,
                                  width: MediaQuery.of(context).size.width,
                                  color: Colors.grey,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text(
                                        data.teamA,
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            fontWeight: FontWeight.w700),
                                      ),
                                      Text("VS"),
                                      Text(data.teamB,
                                          style: TextStyle(
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w700))
                                    ],
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                  )
            //end jadwal
          ],
        ),
      ),
    );
  }
}
