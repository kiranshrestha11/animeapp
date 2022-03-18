import 'dart:convert';
import 'dart:developer';

import 'package:animeapp/data/core/config.dart';
import 'package:http/http.dart';

class ApiClient {
  getData({String endpoint = ''}) async {
    final result = await Client().get(Uri.parse(Config.baseUrl + endpoint));
    final data = jsonDecode(result.body);

    return data;
  }
}
