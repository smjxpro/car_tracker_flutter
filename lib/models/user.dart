/// data : {"id":2,"email":"janet.weaver@reqres.in","first_name":"Janet","last_name":"Weaver","avatar":"https://reqres.in/img/faces/2-image.jpg"}
/// support : {"url":"https://reqres.in/#support-heading","text":"To keep ReqRes free, contributions towards server costs are appreciated!"}

class User {
  Data _data;
  Support _support;

  Data get data => _data;

  Support get support => _support;

  User({Data data, Support support}) {
    _data = data;
    _support = support;
  }

  User.fromJson(dynamic json) {
    _data = json["data"] != null ? Data.fromJson(json["data"]) : null;
    _support =
        json["support"] != null ? Support.fromJson(json["support"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.toJson();
    }
    if (_support != null) {
      map["support"] = _support.toJson();
    }
    return map;
  }
}

/// url : "https://reqres.in/#support-heading"
/// text : "To keep ReqRes free, contributions towards server costs are appreciated!"

class Support {
  String _url;
  String _text;

  String get url => _url;

  String get text => _text;

  Support({String url, String text}) {
    _url = url;
    _text = text;
  }

  Support.fromJson(dynamic json) {
    _url = json["url"];
    _text = json["text"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["url"] = _url;
    map["text"] = _text;
    return map;
  }
}

/// id : 2
/// email : "janet.weaver@reqres.in"
/// first_name : "Janet"
/// last_name : "Weaver"
/// avatar : "https://reqres.in/img/faces/2-image.jpg"

class Data {
  int _id;
  String _email;
  String _firstName;
  String _lastName;
  String _avatar;

  int get id => _id;

  String get email => _email;

  String get firstName => _firstName;

  String get lastName => _lastName;

  String get avatar => _avatar;

  Data(
      {int id,
      String email,
      String firstName,
      String lastName,
      String avatar}) {
    _id = id;
    _email = email;
    _firstName = firstName;
    _lastName = lastName;
    _avatar = avatar;
  }

  Data.fromJson(dynamic json) {
    _id = json["id"];
    _email = json["email"];
    _firstName = json["first_name"];
    _lastName = json["last_name"];
    _avatar = json["avatar"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["id"] = _id;
    map["email"] = _email;
    map["first_name"] = _firstName;
    map["last_name"] = _lastName;
    map["avatar"] = _avatar;
    return map;
  }
}
