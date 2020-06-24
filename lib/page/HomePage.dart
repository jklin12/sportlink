import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sportlink_demo/bloc/BlocBerita.dart';
import 'package:sportlink_demo/bloc/BlocGalery.dart';
import 'package:sportlink_demo/bloc/BlocVidio.dart';
import 'package:sportlink_demo/model/ModelBerita.dart';
import 'package:sportlink_demo/model/ModelEvent.dart';
import 'package:sportlink_demo/model/ModelGalery.dart';
import 'package:sportlink_demo/bloc/BlocEvent.dart';
import 'package:sportlink_demo/page/DetailPage.dart';
import 'package:sportlink_demo/page/DetailVidio.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink_demo/page/LoginPage.dart';
import 'package:sportlink_demo/page/event/EventPageController.dart';
import 'package:sportlink_demo/page/event/OlimpiadePage.dart';
import 'package:sportlink_demo/widget/Header.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userid;
  int value;

  PageController controller;
  bool foll = true;
  final _currentPageNotifier = ValueNotifier<int>(0);

  void getPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      userid = pref.getString("userid");
      value = pref.getInt("value");
      print(userid);
    });
  }

  _updatefollow(String eventid) async {
    if (userid == null) {
      print("Silahkan Login terlebih dahulu");
      Navigator.of(context).push(_loginroute()).then((value) {
        setState(() {
          // refresh state of Page1
          getPref();
          print(userid);
        });
      });
    } else {
      final response = await http
          .post("http://202.169.224.10/api_sportlink/api.php", body: {
        "opsi": "updatefollow",
        "userid": userid,
        "eventid": "$eventid"
      });
      final data = jsonDecode(response.body);
    }
  }

  @override
  void initState() {
    super.initState();
    controller = PageController();
    getPref();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BlocBerita blochighlight = Provider.of<BlocBerita>(context);
    final BlocBerita blocberita = Provider.of<BlocBerita>(context);
    final BlocVidio blocvideo = Provider.of<BlocVidio>(context);
    final BLocEvent blocenvent = Provider.of<BLocEvent>(context);
    final BlocGalery blocgalery = Provider.of<BlocGalery>(context);
    blochighlight.fetchhighligt("hightlight");
    blocenvent.fetchevent(userid);
    blocgalery.fetchgalery();
    blocvideo.fetchvideo();
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              //carousel
              blochighlight.listberita == null
                  ? Container(
                      height: 230.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      child: Container(
                          height: 230.0,
                          child: Stack(
                            children: <Widget>[
                              Container(
                                color: Colors.black87,
                                height: 230,
                                child: PageView.builder(
                                    itemCount: blochighlight.listberita.length,
                                    controller: controller,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final ModelBerita data =
                                          blochighlight.listberita[index];
                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DetailPage(
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
                                              MediaQuery.of(context).size.width,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(data.gambar),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: <Widget>[
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    color: Colors.orange),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(5.0),
                                                  child: Text(
                                                    data.kategori,
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w500),
                                                  ),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 18.0),
                                                child: Text(
                                                  data.judul,
                                                  style: TextStyle(
                                                      color: Color(0Xffffffff),
                                                      fontSize: 20.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      );
                                    },
                                    onPageChanged: (int index) {
                                      _currentPageNotifier.value = index;
                                    }),
                              ),
                              Positioned(
                                left: 0.0,
                                right: 0.0,
                                bottom: 0.0,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: CirclePageIndicator(
                                    dotColor: Colors.white,
                                    itemCount: blochighlight.listberita.length,
                                    currentPageNotifier: _currentPageNotifier,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
              // end of carousel
              // start event
              blocenvent.listevent == null
                  ? Container(
                      height: 300,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      height: 300,
                      width: MediaQuery.of(context).size.width,
                      color: Colors.purple,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "EVENT",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            height: 250.0,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: blocenvent.listevent.length,
                              itemBuilder: (context, index) {
                                ModelEvent data = blocenvent.listevent[index];
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      if (userid == null) {
                                        print("Silahkan Login terlebih dahulu");
                                        Navigator.of(context)
                                            .push(_loginroute())
                                            .then((value) {
                                          setState(() {
                                            // refresh state of Page1
                                            getPref();
                                            print(userid);
                                          });
                                        });
                                      } else {
                                        if (data.level == "turnamen") {
                                          Navigator.of(context).push(
                                              _turnamenroute(
                                                  data.idEvent, data.judul));
                                        } else {
                                          Navigator.of(context).push(
                                              _olimpiaderoute(
                                                  data.idEvent, data.judul));
                                        }
                                      }
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width /
                                          2.3,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Color(int.parse(data.color))),
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
                                                      image: NetworkImage(
                                                          data.logo),
                                                      fit: BoxFit.cover,
                                                    ),
                                                    shape: BoxShape.circle,
                                                    color: Color(0xFFe0f2f1)),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.all(8.0),
                                                child: Text(
                                                  data.judul,
                                                  style: TextStyle(
                                                      color: Color(0Xffffffff),
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w700),
                                                ),
                                              ),
                                            ],
                                          ),
                                          InkWell(
                                              onTap: () {
                                                _updatefollow(data.idEvent);
                                              },
                                              child: data.idFollow == null
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          color: Colors.white),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "FOLLOW",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .purple),
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(3),
                                                          color: Colors.purple),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Text(
                                                          "FOLLOWING",
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.white),
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
              //end event
              //Berita end
              Header(
                title: "BERITA",
                mycolor: 0XFFbe29ec,
                textcolor: 0XFFFFFFFF,
              ),
              blochighlight.listberita == null
                  ? Container(
                      height: 250.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250.0,
                      child: ListView.builder(
                          itemCount: blocberita.listberita.length,
                          itemBuilder: (context, index) {
                            final ModelBerita databerita =
                                blocberita.listberita[index];
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailPage(
                                              judul: databerita.judul,
                                              gambar: databerita.gambar,
                                              tanggal: databerita.tanggal,
                                              pengirim: databerita.pengirim,
                                              isi: databerita.isi,
                                              kategori: databerita.kategori,
                                              level: databerita.level,
                                              vidio: databerita.vidio,
                                            )),
                                  );
                                },
                                child: Container(
                                  child: Row(
                                    children: <Widget>[
                                      Container(
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                            image:
                                                NetworkImage(databerita.gambar),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0.0),
                                              child: Text(
                                                databerita.kategori,
                                                style: TextStyle(
                                                  color: Color(0XFFbe29ec),
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 0.0),
                                              child: Text(
                                                databerita.judul,
                                                style: TextStyle(
                                                  fontSize: 18.0,
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
              //berita end
              //vidio start
              Header(
                title: "VIDEO",
                mycolor: 0XFFf20934,
                textcolor: 0XFFFFFFFF,
              ),
              blochighlight.listberita == null
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
                          itemCount: blocvideo.listberita.length,
                          itemBuilder: (context, index) {
                            final ModelBerita datavideo =
                                blocvideo.listberita[index];
                            return Column(
                              children: <Widget>[
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Detailvidio(
                                                judul: datavideo.judul,
                                                gambar: datavideo.gambar,
                                                tanggal: datavideo.tanggal,
                                                pengirim: datavideo.pengirim,
                                                isi: datavideo.isi,
                                                kategori: datavideo.kategori,
                                                level: datavideo.level,
                                                vidio: datavideo.vidio,
                                              )),
                                    );
                                  },
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 1.2,
                                    height: 200.0,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: NetworkImage(datavideo.gambar),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 5.0),
                                  child: Text(
                                    datavideo.kategori,
                                    style: TextStyle(
                                      color: Color(0XFFbe29ec),
                                      fontSize: 15.0,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 8.0),
                                  child: Text(
                                    datavideo.judul,
                                    style: TextStyle(
                                      fontSize: 18.0,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }),
                    ),
              // vidioend
              //galeri start
              Header(
                title: "GALERI",
                mycolor: 0XFFffc100,
                textcolor: 0XFFFFFFFF,
              ),
              blocgalery.listgalery == null
                  ? Container(
                      height: 250.0,
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      height: 250.0,
                      child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3),
                          itemCount: blocgalery.listgalery.length,
                          itemBuilder: (context, index) {
                            final ModelGalery data =
                                blocgalery.listgalery[index];
                            return Container(
                              width: MediaQuery.of(context).size.width / 3,
                              height: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(data.gambar),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            );
                          }),
                    )
              //galeri end
            ],
          ),
        ),
      ),
    );
  }

  Route _loginroute() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => LoginPage(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _turnamenroute(String id, String title) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) =>
          EventPageController(
        enevtid: id,
        title: title,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  Route _olimpiaderoute(String id, String title) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => OlimpiadePage(
        enevtid: id,
        title: title,
      ),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(0.0, 1.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }
}
