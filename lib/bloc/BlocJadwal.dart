import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink_demo/model/ModelJadwal.dart';
import 'package:sportlink_demo/model/ModelPemain.dart';

class BlocJadwal extends ChangeNotifier {
  final _apiUrl = "http://202.169.224.10/api_sportlink/api.php";
  //Prototype get list data from json
  List<ModelJadwal> _listjadwal;
  List<ModelJadwal> get listjadwal => _listjadwal;
  set listjadwal(List<ModelJadwal> val) {
    _listjadwal = val;
    notifyListeners();
  }

  Future<List<ModelJadwal>> fetchjadwal(String eventid) async {
    final response = await http
        .post('$_apiUrl', body: {"opsi": "jadwal", "idevent": eventid});
    List myData = modelJadwalFromJson(response.body);
    listjadwal = myData;
    return listjadwal;
  }
}
