import 'dart:convert';

import 'package:cpims_mobile/services/api_service.dart';

class DashBoardService {
  Future<dynamic> dashBoard(access) async {
    var response = await ApiService().getSecureData("dashboard/", access);
    var dashboard = json.decode(response.body);
    return dashboard;
  }
}
