import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:provider/provider.dart';
import 'package:sportlink_demo/bloc/BlocMedali.dart';

class OlimpiadeMedaliPage extends StatefulWidget {
  OlimpiadeMedaliPage({this.id, this.namaevent});
  final String id;
  final String namaevent;
  @override
  _OlimpiadeMedaliPageState createState() => _OlimpiadeMedaliPageState();
}

class _OlimpiadeMedaliPageState extends State<OlimpiadeMedaliPage> {
  @override
  Widget build(BuildContext context) {
    final BlocMedali blocmedali = Provider.of<BlocMedali>(context);
    blocmedali.fetchmedali(widget.id);
    return Scaffold(
      appBar: AppBar(
          title: Text(
            "Medali",
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
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                widget.namaevent,
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "PEROLEHAN MEDALI",
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Text(
                Jiffy(DateTime.now()).format("MMMM do yyyy, h:mm:ss a."),
                style:
                    TextStyle(color: Colors.blue, fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: DataTable(
                columnSpacing: 10.0,
                  columns: <DataColumn>[
                    DataColumn(
                      label: Text("Pos"),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text("Wilayah"),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text("Emas"),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text("Perak"),
                      numeric: false,
                    ),
                    DataColumn(
                      label: Text("Perunggu"),
                      numeric: false,
                    )
                  ],
                  rows: blocmedali.listmedali
                      .map(
                        (name) => DataRow(
                          cells: [
                            DataCell(
                              Text(name.id),
                              showEditIcon: false,
                              placeholder: false,
                            ),
                            DataCell(
                              Text(name.wilayah),
                              showEditIcon: false,
                              placeholder: false,
                            ),
                            DataCell(
                              Text(name.emas),
                              showEditIcon: false,
                              placeholder: false,
                            ),
                            DataCell(
                              Text(name.perak),
                              showEditIcon: false,
                              placeholder: false,
                            ),
                            DataCell(
                              Text(name.perunggu),
                              showEditIcon: false,
                              placeholder: false,
                            )
                          ],
                        ),
                      )
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
