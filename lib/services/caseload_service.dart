import 'dart:convert';

import 'package:cpims_mobile/Models/case_load.dart';
import 'package:cpims_mobile/constants.dart';
import 'package:cpims_mobile/providers/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CaseLoadService {
  Future<void> fetchCaseLoadData({
    required BuildContext context,
    required bool isForceSync,
  }) async {
    final preferences = await SharedPreferences.getInstance();
    final int caseloadLastSave = preferences.getInt('caseload_last_save') ?? 0;
    final int currentTimestamp = DateTime.now().millisecondsSinceEpoch;
    final int diff = currentTimestamp - caseloadLastSave;
    if (!(isForceSync || diff > 60000)) { // Todo : 30 days - 2592000000 milliseconds
      return;
    }


    try {

      final accessToken = preferences.getString('access');
      http.Response response = await http.get(
        Uri.parse('${cpimsApiUrl}caseload'),
        headers: {
          'Authorization': 'Bearer $accessToken',
        },
      );

      if (response.statusCode == 200) {
        for (int i = 0; i < jsonDecode(response.body).length; i++) {
          CaseLoadModel caseLoadModel = CaseLoadModel.fromJson(
            jsonDecode(response.body)[i],
          );
          bool dataInserted = false;
          if(!dataInserted){

            CaseLoadDb.instance.insertDoc(caseLoadModel);
            dataInserted = true;

          }
        }
        final int timestamp = DateTime.now().millisecondsSinceEpoch;
        await preferences.setInt('caseload_last_save', timestamp);
      } else {
        print("We have an issue");
      }
    } catch (e) {
      errorSnackBar(context, e.toString());
    }
  }
}
