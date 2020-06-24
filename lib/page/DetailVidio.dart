import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:video_player/video_player.dart';

class Detailvidio extends StatefulWidget {
  Detailvidio({
    this.id,
    this.level,
    this.judul,
    this.kategori,
    this.gambar,
    this.vidio,
    this.isi,
    this.pengirim,
    this.tanggal,
  });

  final String id;
  final String level;
  final String judul;
  final String kategori;
  final String gambar;
  final String vidio;
  final String isi;
  final String pengirim;
  final DateTime tanggal;
  @override
  _DetailvidioState createState() => _DetailvidioState();
}

class _DetailvidioState extends State<Detailvidio> {
  VideoPlayerController _videoPlayerController1;
  ChewieController _chewieController;
  bool fav = true;
  bool ratee = true;
  String tgl;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    tgl = Jiffy(widget.tanggal).format("MMM do yy");
    _videoPlayerController1 = VideoPlayerController.network(widget.vidio);
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController1,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: true,
    );
    print(widget.vidio);
  }

  @override
  void dispose() {
    super.dispose();
    _chewieController.dispose();
    _videoPlayerController1.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
            icon: new Icon(
              Icons.more_vert,
              color: Colors.black,
            ),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Center(
          child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              child: Chewie(
                controller: _chewieController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8.0),
              child: Text(
                widget.kategori,
                style: TextStyle(fontSize: 15.0, color: Colors.red),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 8.0),
              child: Text(
                widget.judul,
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 15.0,
              ),
              child: Text(
                Jiffy(widget.tanggal).format("MMMM do yyyy, h:mm:ss a"),
                style: TextStyle(fontSize: 15.0, color: Colors.blue),
              ),
            ),
            /*Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        height: 2.0,
                        width: MediaQuery.of(context).size.width,
                        color: Color(0XFFDDDDDD),
                      ),
                    ),*/
            Padding(
              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 8.0),
              child: Container(
                child: Text(
                  widget.isi,
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: 'Open-Sans',
                    fontWeight: FontWeight.w300,
                    fontSize: 15.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
