import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:belajar_api/model.dart';

class Repository {
  final _baseUrl = 'https://6284436a3060bbd347366094.mockapi.io';

  Future getData() async {
    try {
      final response = await http.get(Uri.parse(_baseUrl + '/users'));

      if (response.statusCode == 200) {
        print(response.body);
        Iterable it = jsonDecode(response.body);
        List<Users> users = it.map((e) => Users.fromJson(e)).toList();
        return users;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future postData(String title, String content) async {
    try {
      final response = await http.post(Uri.parse(_baseUrl + '/users'), body: {
        'title': title,
        'content': content,
      });
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future putData(int id, String title, String content) async {
    try {
      final response = await http.put(
          Uri.parse(_baseUrl + '/users/' + id.toString()),
          body: {'title': title, 'content': content});
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }

  Future deleteData(String id) async {
    try {
      final response = await http.delete(Uri.parse(_baseUrl + '/users/' + id));
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
