import 'dart:developer';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fbi_most_wanted_app/constants.dart';
import 'package:fbi_most_wanted_app/model/people.dart';
import 'package:fbi_most_wanted_app/model/person.dart';

class ApiService {
  // Lifecycle

  ApiService._();
  static final instance = ApiService._();

  // Public

  Future<List<Person>?> getUsers() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.listEndpoint);
      var response = await http.get(url);

      if (response.statusCode == 200) {
        People people = _peopleFromJson(response.body);
        return people.items;
      } else {
        return null;
      }
    } catch (error) {
      log(error.toString());
      return null;
    }
  }

  // Private

  People _peopleFromJson(String str) => People.fromJson(json.decode(str));
}
