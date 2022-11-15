
class LoginReponseModel {
  final String message;
  final String errors;
  final String user;
  final String first_name;
  final String last_name;
  final String email;
  final String gender;
  final String from;
  final String tel;
  final String id;
  LoginReponseModel({
    required this.message,
    required this.errors,
    required this.user,
    required this.first_name,
    required this.last_name,
    required this.email,
    required this.gender,
    required this.from,
    required this.tel,
    required this.id,
  });
  factory LoginReponseModel.fromJson(Map<String, dynamic> json) {
    return LoginReponseModel(
        message: json["message"] ?? "",
        errors: json["error"] ?? "",
        user: json['user']['username'],
        first_name: json['user']['first_name'],
        last_name: json['user']['last_name'],
        email: json['user']['email'],
        gender: json['user']['gender'],
        from: json['user']['known_from'],
        tel: json['user']['tel_num'],
        id: json['user']['id'].toString());
  }
}

class LoginRequestModel {
  late String email;
  late String password;

  LoginRequestModel({
    required this.email,
    required this.password,
  });
  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      "email": email.trim(),
      "password": password.trim(),
    };
    return map;
  }
}
