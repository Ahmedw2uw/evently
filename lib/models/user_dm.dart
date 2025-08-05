
class UserDm {
  static const String userColictionName = "users";
  static UserDm? curentUser; //* this to can invoke the user in all widgets
  late String id;
  late String email;
  late String name;
  late List<String> favorateEvents;
  UserDm({
    required this.id,
    required this.email,
    required this.name,
    required this.favorateEvents,
  });

  UserDm.fromJson(Map json) {
    id = json["id"];
    email = json["email"];
    name = json["name"];
    List<dynamic> favEvent =
        json["favorateEvents"] ??
        []; //*this contains of the all favorate id as list
    favorateEvents =
        favEvent
            .map((id) => id.toString())
            .toList(); //*hear convert theer to string
  }
  Map<String, dynamic> tojson() {
    //* this reblace the set function
    return {
      "id": id,
      "email": email,
      "name": name,
      "favorateEvents": favorateEvents,
    };
  }
}
