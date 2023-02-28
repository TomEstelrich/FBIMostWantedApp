import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:fbi_most_wanted_app/constants.dart';
import 'package:fbi_most_wanted_app/model/people_model.dart';

class ApiService {
  Future<List<Item>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.listEndpoint);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        People _people = peopleFromJson(response.body);
        return _people.items;
      }
    } catch (e) {
      log(e.toString());
    }
  }
}
