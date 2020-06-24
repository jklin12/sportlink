import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:sportlink_demo/model/ModelEvent.dart';
import 'package:http/http.dart' as http;

class BLocEvent extends ChangeNotifier {
  final _apiUrl = "http://202.169.224.10/api_sportlink/api.php";
  //Prototype get list data from json
  List<ModelEvent> _event;
  List<ModelEvent> get listevent => _event;
  set listevent(List<ModelEvent> val) {
    _event = val;
    notifyListeners();
  }

  Future<List<ModelEvent>> fetchevent(String userid) async {
    if (userid == null) {
      final response =
          await http.post('$_apiUrl', body: {"opsi": "event", "userid": "0"});
      List myData = modelEventFromJson(response.body);
      listevent = myData;
      return listevent;
    } else {
      final response = await http
          .post('$_apiUrl', body: {"opsi": "event", "userid": "$userid"});
      List myData = modelEventFromJson(response.body);
      listevent = myData;
      return listevent;
    }
  }
}
