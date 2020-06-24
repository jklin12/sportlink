import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sportlink_demo/model/ModelBerita.dart';
import 'package:http/http.dart' as http;

class BlocBeritaEvent extends ChangeNotifier {
  final _apiUrl = "http://202.169.224.10/api_sportlink/api.php";
  //Prototype get list data from json
  List<ModelBerita> _berita;
  List<ModelBerita> get listberita => _berita;
  set listberita(List<ModelBerita> val) {
    _berita = val;
    notifyListeners();
  }

  Future<List<ModelBerita>> fetchhighligt(String level) async {
    final response =
        await http.post('$_apiUrl', body: {"opsi": "berita", "level": level});
    List myData = modelBeritaFromJson(response.body);
    listberita = myData;
    return listberita;
  }
}
