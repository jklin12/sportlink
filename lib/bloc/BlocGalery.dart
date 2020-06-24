

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink_demo/model/ModelGalery.dart';

class BlocGalery extends ChangeNotifier {
  //Prototype get list data from json
  final _apiUrl = "http://202.169.224.10/api_sportlink/api.php";
  List<ModelGalery> _galery;
  List<ModelGalery> get listgalery => _galery;
  set listgalery(List<ModelGalery> val) {
    _galery = val;
    notifyListeners();
  }

  Future<List<ModelGalery>> fetchgalery() async {
    final response = await http.post(
        '$_apiUrl',
        body: {"opsi": "galeri"});
    List myData = modelGaleryFromJson(response.body);
    listgalery = myData;
    return listgalery;
  }
}
