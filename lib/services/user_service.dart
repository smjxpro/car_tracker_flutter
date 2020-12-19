import 'dart:convert';

import 'package:car_tracker_flutter/interfaces/i_user_service.dart';
import 'package:car_tracker_flutter/models/user.dart';
import 'package:http/http.dart' as http;

class UserService implements IUserService {
  var url = 'https://reqres.in/api/users/2';

  var _client = http.Client();

  set client(http.Client client) => _client = client;

  @override
  Future<User> getUser() async {
    User user = User();
    var response = await _client.get(url);

    if (response.statusCode == 200) {
      var userMap = jsonDecode(response.body);
      user = User.fromJson(userMap);
    }

    return user;
  }
}
