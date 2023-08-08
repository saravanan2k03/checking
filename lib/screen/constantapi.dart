// ignore_for_file: camel_case_types, non_constant_identifier_names

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../functions/variables.dart';

class constantapi {
  Future CompleteCollection() async {
    final http.Response response = await http.post(
      Uri.parse('$ip/collection/CompleteCollection'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'AgentId': store.read('id').toString(),
        },
      ),
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("Completed");
      }
    }
  }

  collectionchecking() async {
    final http.Response response =
        await http.post(Uri.parse('$ip/collection//Collectioncheck'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode({
              'id': store.read('id'),
            }));
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.body);
      }
      if (response.body == "Already Exist") {
        check_col = false;
      } else {
        check_col = true;
      }
    }
  }
}
