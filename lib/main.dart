import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sportlink_demo/bloc/BlocBerita.dart';
import 'package:sportlink_demo/bloc/BlocEvent.dart';
import 'package:sportlink_demo/bloc/BlocGalery.dart';
import 'package:sportlink_demo/bloc/BlocJadwal.dart';
import 'package:sportlink_demo/bloc/BlocJadwalOlimpiade.dart';
import 'package:sportlink_demo/bloc/BlocMedali.dart';
import 'package:sportlink_demo/bloc/BlocPemain.dart';
import 'package:sportlink_demo/bloc/BlocTimeline.dart';
import 'package:sportlink_demo/bloc/BlocVidio.dart';
import 'package:sportlink_demo/bloc/blocberitaevent.dart';
import 'package:sportlink_demo/bloc/BlocUgc.dart';
import 'package:sportlink_demo/widget/PageController.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<BlocBerita>.value(value: BlocBerita()),
        ChangeNotifierProvider<BLocEvent>.value(value: BLocEvent()),
        ChangeNotifierProvider<BlocGalery>.value(value: BlocGalery()),
        ChangeNotifierProvider<BlocUgc>.value(value: BlocUgc()),
        ChangeNotifierProvider<BlocTimeline>.value(value: BlocTimeline()),
        ChangeNotifierProvider<BlocVidio>.value(value: BlocVidio()),
        ChangeNotifierProvider<BlocBeritaEvent>.value(value: BlocBeritaEvent()),
        ChangeNotifierProvider<BlocPemain>.value(value: BlocPemain()),
        ChangeNotifierProvider<BlocJadwal>.value(value: BlocJadwal()),
        ChangeNotifierProvider<BlocMedali>.value(value: BlocMedali()),
        ChangeNotifierProvider<BlocJadwalOlimpiade>.value(value: BlocJadwalOlimpiade()),
      ],
      child: MaterialApp(
        home: PageCtrl(),
        title: 'Sportlink',
      ),
    );
  }
}
