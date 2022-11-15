class properties {
  List<Property>? property;

  properties({this.property});

  properties.fromJson(Map<String, dynamic> json) {
    if (json['property'] != null) {
      property = <Property>[];
      json['property'].forEach((v) {
        property!.add(new Property.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.property != null) {
      data['property'] = this.property!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Property {
  String? propertyTypeId;
  String? propertyTypeName;
  String? propertyTypePublished;
  String? propertyTypeColor;
  Null? propertyColos;
  Null? propertyTypeCreatedBy;
  String? propertyTypeCreatedDate;
  Null? propertyTypeModifyBy;
  Null? propertyTypeModifyDate;

  Property(
      {this.propertyTypeId,
      this.propertyTypeName,
      this.propertyTypePublished,
      this.propertyTypeColor,
      this.propertyColos,
      this.propertyTypeCreatedBy,
      this.propertyTypeCreatedDate,
      this.propertyTypeModifyBy,
      this.propertyTypeModifyDate});

  Property.fromJson(Map<String, dynamic> json) {
    propertyTypeId = json['property_type_id'];
    propertyTypeName = json['property_type_name'];
    propertyTypePublished = json['property_type_published'];
    propertyTypeColor = json['property_type_color'];
    propertyColos = json['property_colos'];
    propertyTypeCreatedBy = json['property_type_created_by'];
    propertyTypeCreatedDate = json['property_type_created_date'];
    propertyTypeModifyBy = json['property_type_modify_by'];
    propertyTypeModifyDate = json['property_type_modify_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['property_type_id'] = this.propertyTypeId;
    data['property_type_name'] = this.propertyTypeName;
    data['property_type_published'] = this.propertyTypePublished;
    data['property_type_color'] = this.propertyTypeColor;
    data['property_colos'] = this.propertyColos;
    data['property_type_created_by'] = this.propertyTypeCreatedBy;
    data['property_type_created_date'] = this.propertyTypeCreatedDate;
    data['property_type_modify_by'] = this.propertyTypeModifyBy;
    data['property_type_modify_date'] = this.propertyTypeModifyDate;
    return data;
  }
}
