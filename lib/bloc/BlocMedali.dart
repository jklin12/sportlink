import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink_demo/model/ModelMedali.dart';

class BlocMedali extends ChangeNotifier {
  final _apiUrl = "http://202.169.224.10/api_sportlink/api.php";
  //Prototype get list data from json
  List<ModelMedali> _medali;
  List<ModelMedali> get listmedali => _medali;
  set listmedali(List<ModelMedali> val) {
    _medali = val;
    notifyListeners();
  }

  Future<List<ModelMedali>> fetchmedali(String idevent) async {
    final response = await http
        .post('$_apiUrl', body: {"opsi": "medali", "idevent": idevent});
    List myData = modelMedaliFromJson(response.body);
    listmedali = myData;
    return listmedali;
  }
}
