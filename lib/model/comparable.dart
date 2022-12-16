// ignore_for_file: unnecessary_question_mark, unnecessary_new, prefer_collection_literals, unnecessary_this, prefer_void_to_null

class Comparable {
  int? currentPage;
  List<Data>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  List<Links>? links;
  String? nextPageUrl;
  String? path;
  int? perPage;

  Null? prevPageUrl;
  int? to;
  int? total;

  Comparable(
      {this.currentPage,
      this.data,
      this.firstPageUrl,
      this.from,
      this.lastPage,
      this.lastPageUrl,
      this.links,
      this.nextPageUrl,
      this.path,
      this.perPage,
      this.prevPageUrl,
      this.to,
      this.total});

  Comparable.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = this.firstPageUrl;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['last_page_url'] = this.lastPageUrl;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    data['next_page_url'] = this.nextPageUrl;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['prev_page_url'] = this.prevPageUrl;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}

class Data {
  String? comparableId;
  String? comparablePropertyId;
  String? comparableLandLength;
  String? comparableLandWidth;
  String? comparableLandTotal;
  String? comparableSoldLength;
  String? comparableSoldWidth;
  String? comparableSoldTotal;
  String? comparableAddingPrice;
  String? comparableAddingTotal;
  String? comparableSoldPrice;
  String? comparableSoldTotalPrice;
  String? comparableConditionId;
  String? comparableYear;
  String? comparableAddress;
  String? comparableProvinceId;
  String? comparableDistrictId;
  String? comparableCommuneId;
  String? comparableRemark;
  String? comparableSurveyDate;
  Null? comparableDate;
  String? comparablePhone;
  Null? comparableFromDate;
  Null? comparableToDate;
  Null? comparableDistance;
  Null? comparableStatusId;
  Null? comparableaddprice;
  String? comparableaddpricetotal;
  String? comparableboughtprice;
  Null? comparableAmount;
  String? latlongLog;
  String? latlongLa;
  String? comparablUser;
  String? comparableCon;
  String? comparableboughtpricetotal;
  String? conditionImagePublished;
  Null? conditionImageCreatedBy;
  String? conditionImageCreatedDate;
  String? conditionImageModifyBy;
  String? conditionImageModifyDate;
  String? compareBankId;
  String? compareBankBranchId;
  Null? comBankofficer;
  Null? comBankofficerContact;
  Null? comparableRoad;

  Data(
      {this.comparableId,
      this.comparablePropertyId,
      this.comparableLandLength,
      this.comparableLandWidth,
      this.comparableLandTotal,
      this.comparableSoldLength,
      this.comparableSoldWidth,
      this.comparableSoldTotal,
      this.comparableAddingPrice,
      this.comparableAddingTotal,
      this.comparableSoldPrice,
      this.comparableSoldTotalPrice,
      this.comparableConditionId,
      this.comparableYear,
      this.comparableAddress,
      this.comparableProvinceId,
      this.comparableDistrictId,
      this.comparableCommuneId,
      this.comparableRemark,
      this.comparableSurveyDate,
      this.comparableDate,
      this.comparablePhone,
      this.comparableFromDate,
      this.comparableToDate,
      this.comparableDistance,
      this.comparableStatusId,
      this.comparableaddprice,
      this.comparableaddpricetotal,
      this.comparableboughtprice,
      this.comparableAmount,
      this.latlongLog,
      this.latlongLa,
      this.comparablUser,
      this.comparableCon,
      this.comparableboughtpricetotal,
      this.conditionImagePublished,
      this.conditionImageCreatedBy,
      this.conditionImageCreatedDate,
      this.conditionImageModifyBy,
      this.conditionImageModifyDate,
      this.compareBankId,
      this.compareBankBranchId,
      this.comBankofficer,
      this.comBankofficerContact,
      this.comparableRoad});

  Data.fromJson(Map<String, dynamic> json) {
    comparableId = json['comparable_id'];
    comparablePropertyId = json['comparable_property_id'];
    comparableLandLength = json['comparable_land_length'];
    comparableLandWidth = json['comparable_land_width'];
    comparableLandTotal = json['comparable_land_total'];
    comparableSoldLength = json['comparable_sold_length'];
    comparableSoldWidth = json['comparable_sold_width'];
    comparableSoldTotal = json['comparable_sold_total'];
    comparableAddingPrice = json['comparable_adding_price'];
    comparableAddingTotal = json['comparable_adding_total'];
    comparableSoldPrice = json['comparable_sold_price'];
    comparableSoldTotalPrice = json['comparable_sold_total_price'];
    comparableConditionId = json['comparable_condition_id'];
    comparableYear = json['comparable_year'];
    comparableAddress = json['comparable_address'];
    comparableProvinceId = json['comparable_province_id'];
    comparableDistrictId = json['comparable_district_id'];
    comparableCommuneId = json['comparable_commune_id'];
    comparableRemark = json['comparable_remark'];
    comparableSurveyDate = json['comparable_survey_date'];
    comparableDate = json['comparableDate'];
    comparablePhone = json['comparable_phone'];
    comparableFromDate = json['comparable_from_date'];
    comparableToDate = json['comparable_to_date'];
    comparableDistance = json['comparable_distance'];
    comparableStatusId = json['comparable_status_id'];
    comparableaddprice = json['comparableaddprice'];
    comparableaddpricetotal = json['comparableaddpricetotal'];
    comparableboughtprice = json['comparableboughtprice'];
    comparableAmount = json['comparableAmount'];
    latlongLog = json['latlong_log'];
    latlongLa = json['latlong_la'];
    comparablUser = json['comparabl_user'];
    comparableCon = json['comparable_con'];
    comparableboughtpricetotal = json['comparableboughtpricetotal'];
    conditionImagePublished = json['condition_image_published'];
    conditionImageCreatedBy = json['condition_image_created_by'];
    conditionImageCreatedDate = json['condition_image_created_date'];
    conditionImageModifyBy = json['condition_image_modify_by'];
    conditionImageModifyDate = json['condition_image_modify_date'];
    compareBankId = json['compare_bank_id'];
    compareBankBranchId = json['compare_bank_branch_id'];
    comBankofficer = json['com_bankofficer'];
    comBankofficerContact = json['com_bankofficer_contact'];
    comparableRoad = json['comparable_road'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['comparable_id'] = this.comparableId;
    data['comparable_property_id'] = this.comparablePropertyId;
    data['comparable_land_length'] = this.comparableLandLength;
    data['comparable_land_width'] = this.comparableLandWidth;
    data['comparable_land_total'] = this.comparableLandTotal;
    data['comparable_sold_length'] = this.comparableSoldLength;
    data['comparable_sold_width'] = this.comparableSoldWidth;
    data['comparable_sold_total'] = this.comparableSoldTotal;
    data['comparable_adding_price'] = this.comparableAddingPrice;
    data['comparable_adding_total'] = this.comparableAddingTotal;
    data['comparable_sold_price'] = this.comparableSoldPrice;
    data['comparable_sold_total_price'] = this.comparableSoldTotalPrice;
    data['comparable_condition_id'] = this.comparableConditionId;
    data['comparable_year'] = this.comparableYear;
    data['comparable_address'] = this.comparableAddress;
    data['comparable_province_id'] = this.comparableProvinceId;
    data['comparable_district_id'] = this.comparableDistrictId;
    data['comparable_commune_id'] = this.comparableCommuneId;
    data['comparable_remark'] = this.comparableRemark;
    data['comparable_survey_date'] = this.comparableSurveyDate;
    data['comparableDate'] = this.comparableDate;
    data['comparable_phone'] = this.comparablePhone;
    data['comparable_from_date'] = this.comparableFromDate;
    data['comparable_to_date'] = this.comparableToDate;
    data['comparable_distance'] = this.comparableDistance;
    data['comparable_status_id'] = this.comparableStatusId;
    data['comparableaddprice'] = this.comparableaddprice;
    data['comparableaddpricetotal'] = this.comparableaddpricetotal;
    data['comparableboughtprice'] = this.comparableboughtprice;
    data['comparableAmount'] = this.comparableAmount;
    data['latlong_log'] = this.latlongLog;
    data['latlong_la'] = this.latlongLa;
    data['comparabl_user'] = this.comparablUser;
    data['comparable_con'] = this.comparableCon;
    data['comparableboughtpricetotal'] = this.comparableboughtpricetotal;
    data['condition_image_published'] = this.conditionImagePublished;
    data['condition_image_created_by'] = this.conditionImageCreatedBy;
    data['condition_image_created_date'] = this.conditionImageCreatedDate;
    data['condition_image_modify_by'] = this.conditionImageModifyBy;
    data['condition_image_modify_date'] = this.conditionImageModifyDate;
    data['compare_bank_id'] = this.compareBankId;
    data['compare_bank_branch_id'] = this.compareBankBranchId;
    data['com_bankofficer'] = this.comBankofficer;
    data['com_bankofficer_contact'] = this.comBankofficerContact;
    data['comparable_road'] = this.comparableRoad;
    return data;
  }
}

class Links {
  String? url;
  String? label;
  bool? active;

  Links({this.url, this.label, this.active});

  Links.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    label = json['label'];
    active = json['active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['url'] = this.url;
    data['label'] = this.label;
    data['active'] = this.active;
    return data;
  }
}
