import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink_demo/model/ModelPemain.dart';
import 'package:sportlink_demo/model/ModelTimeLine.dart';

class BlocPemain extends ChangeNotifier {
  final _apiUrl = "http://202.169.224.10/api_sportlink/api.php";
  //Prototype get list data from json
  List<ModelPemain> _listpemain;
  List<ModelPemain> get listpemain => _listpemain;
  set listpemain(List<ModelPemain> val) {
    _listpemain = val;
    notifyListeners();
  }

  Future<List<ModelPemain>> fetchpemain(String eventid) async {
    final response = await http.post(
        '$_apiUrl',
        body: {"opsi": "pemain", "idevent": eventid});
    List myData = modelPemainFromJson(response.body);
    listpemain = myData;
    return listpemain;
  }
}
