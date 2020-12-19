import 'package:car_tracker_flutter/models/user.dart';

abstract class IUserService {
  Future<User> getUser();
}
