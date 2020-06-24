import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportlink_demo/bloc/BlocUgc.dart';
import 'package:sportlink_demo/model/ModelTimeLine.dart';
import 'package:sportlink_demo/model/ModelUgc.dart';
import 'package:jiffy/jiffy.dart';

class TimeLinepage extends StatefulWidget {
  @override
  _TimeLinepageState createState() => _TimeLinepageState();
}

class _TimeLinepageState extends State<TimeLinepage> {
  bool fav = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final BlocUgc blocUgc = Provider.of<BlocUgc>(context);
    blocUgc.fetchUgc("1");
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              // Add your onPressed code here!
            },
            child: Icon(Icons.add),
            backgroundColor: Colors.green,
          ),
          body: SingleChildScrollView(
            child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: viewportConstraints.maxHeight,
                ),
                child: blocUgc.listUgc == null
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container(
                        width: MediaQuery.of(context).size.width,
                        height: 500.0,
                        child: ListView.builder(
                            itemCount: blocUgc.listUgc.length,
                            itemBuilder: (context, index) {
                              final ModelUgc data = blocUgc.listUgc[index];

                              var wkatuupload =
                                  Jiffy(data.dataPost.tanggalUpload).fromNow();
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                child: Column(children: <Widget>[
                                  ListTile(
                                    leading: Container(
                                      width: 50,
                                      height: 50,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(
                                                data.dataPost.avatar),
                                            fit: BoxFit.cover,
                                          ),
                                          shape: BoxShape.circle,
                                          color: Color(0xFFe0f2f1)),
                                    ),
                                    trailing: Icon(Icons.more_vert),
                                    title: Text(data.dataPost.username),
                                    subtitle: Text(wkatuupload),
                                  ),
                                  Image.network(
                                    data.dataPost.gambar,
                                    width: MediaQuery.of(context).size.width,
                                  ),
                                  Container(
                                    color: Color(0XFFEEEEEf),
                                    height: 50.0,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: <Widget>[
                                                InkWell(
                                                  onTap: () {
                                                    if (fav == false) {
                                                      setState(() {
                                                        fav = true;
                                                      });
                                                    } else {
                                                      setState(() {
                                                        fav = false;
                                                      });
                                                    }
                                                  },
                                                  child: fav
                                                      ? Icon(
                                                          Icons.favorite_border,
                                                        )
                                                      : Icon(
                                                          Icons.favorite,
                                                          color: Colors.red,
                                                        ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Text(
                                                    data.dataLike.jmllikes +
                                                        " Likes",
                                                    style: TextStyle(
                                                        fontSize: 15.0,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Container(
                                            child: Row(
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 8.0),
                                                  child: Icon(Icons.comment),
                                                ),
                                                Text(
                                                  data.dataComent.jmlcoments +
                                                      "100 Coments",
                                                  style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Text(
                                        data.dataPost.caption,
                                        style: TextStyle(
                                            fontSize: 15.0,
                                            fontWeight: FontWeight.w400),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      height: 3.0,
                                      width: MediaQuery.of(context).size.width,
                                      color: Color(0XFFEEEEEf))
                                ]),
                              );
                            }),
                      )),
          ),
        );
      },
    );
  }
}
