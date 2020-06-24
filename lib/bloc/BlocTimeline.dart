import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:sportlink_demo/model/ModelTimeLine.dart';

class BlocTimeline extends ChangeNotifier {
  final _apiUrl = "http://202.169.224.10/api_sportlink/api.php";
  //Prototype get list data from json
  List<ModelTimeline> _timeline;
  List<ModelTimeline> get listtimeline => _timeline;
  set listtimeline(List<ModelTimeline> val) {
    _timeline = val;
    notifyListeners();
  }

  Future<List<ModelTimeline>> fetchtimeline(String userid) async {
    if (userid == null) {
      print("nothing");
    } else {
      final response = await http
          .post('$_apiUrl', body: {"opsi": "timeline", "userid": userid});
      List myData = modelTimelineFromJson(response.body);
      listtimeline = myData;
      return listtimeline;
    }
  }
}
