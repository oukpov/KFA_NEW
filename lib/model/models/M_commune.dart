class M_Commune {
  String? communename;
  String? district;
  String? province;
  double? longitude;
  double? latitude;

  M_Commune(
      {this.communename,
      this.district,
      this.province,
      this.longitude,
      this.latitude});

  M_Commune.fromJson(Map<String, dynamic> json) {
    communename = json['commune_name'];
    district = json['district'];
    province = json['province'];
    longitude = json['longitude'];
    latitude = json['latitude'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['commune_name'] = communename;
    data['district'] = district;
    data['province'] = province;
    data['longitude'] = longitude;
    data['latitude'] = latitude;
    return data;
  }
}

class M_CommuneReponeModel {
  final String message;
  M_CommuneReponeModel({
    required this.message,
  });
  factory M_CommuneReponeModel.fromJson(Map<String, dynamic> json) {
    return M_CommuneReponeModel(
      message: json["message"] ?? "",
    );
  }
}
