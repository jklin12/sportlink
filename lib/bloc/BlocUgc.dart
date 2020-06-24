import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink_demo/model/ModelUgc.dart';

class BlocUgc extends ChangeNotifier {
  final _apiUrl = "http://202.169.224.10/api_sportlink/api.php";
  //Prototype get list data from json
  List<ModelUgc> _listUgc;
  List<ModelUgc> get listUgc => _listUgc;
  set listUgc(List<ModelUgc> val) {
    _listUgc = val;
    notifyListeners();
  }

  Future<List<ModelUgc>> fetchUgc(String userid) async {
    final response =
        await http.post('$_apiUrl', body: {"opsi": "ugc", "id": "$userid"});
    List myData = modelUgcFromJson(response.body);
    listUgc = myData;
    return listUgc;
  }
}
