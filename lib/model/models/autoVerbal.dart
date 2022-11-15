// class Autoverbal {
//   List<Data>? data;

//   Autoverbal({this.data});

//   Autoverbal.fromJson(Map<String, dynamic> json) {
//     if (json['data'] != null) {
//       data = <Data>[];
//       json['data'].forEach((v) {
//         data!.add(new Data.fromJson(v));
//       });
//     }
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     if (this.data != null) {
//       data['data'] = this.data!.map((v) => v.toJson()).toList();
//     }
//     return data;
//   }
// }

// class Data {
//   String? verbalId;
//   String? verbalPropertyId;
//   String? verbalPropertyCode;
//   String? verbalBankId;
//   String? verbalBankBranchId;
//   String? verbalBankContact;
//   String? verbalOwner;
//   String? verbalContact;
//   String? verbalDate;
//   String? verbalBankOfficer;
//   String? verbalAddress;
//   String? verbalProvinceId;
//   String? verbalDistrictId;
//   String? verbalCommuneId;
//   String? verbalApproveId;
//   Null? verbalApprovesId;
//   String? verbalComment;
//   String? verbalImage;
//   String? latlongLog;
//   String? latlongLa;
//   String? verbalCom;
//   String? verbalCon;
//   String? verbalOption;
//   String? verbalStatusId;
//   String? verbalPublished;
//   String? verbalUser;
//   String? verbalComp;
//   String? verifyAgent;
//   Null? verbalCreatedBy;
//   String? verbalCreatedDate;
//   Null? verbalModifyBy;

//   Data(
//       {this.verbalId,
//       this.verbalPropertyId,
//       this.verbalPropertyCode,
//       this.verbalBankId,
//       this.verbalBankBranchId,
//       this.verbalBankContact,
//       this.verbalOwner,
//       this.verbalContact,
//       this.verbalDate,
//       this.verbalBankOfficer,
//       this.verbalAddress,
//       this.verbalProvinceId,
//       this.verbalDistrictId,
//       this.verbalCommuneId,
//       this.verbalApproveId,
//       this.verbalApprovesId,
//       this.verbalComment,
//       this.verbalImage,
//       this.latlongLog,
//       this.latlongLa,
//       this.verbalCom,
//       this.verbalCon,
//       this.verbalOption,
//       this.verbalStatusId,
//       this.verbalPublished,
//       this.verbalUser,
//       this.verbalComp,
//       this.verifyAgent,
//       this.verbalCreatedBy,
//       this.verbalCreatedDate,
//       this.verbalModifyBy});

//   Data.fromJson(Map<String, dynamic> json) {
//     verbalId = json['verbal_id'];
//     verbalPropertyId = json['verbal_property_id'];
//     verbalPropertyCode = json['verbal_property_code'];
//     verbalBankId = json['verbal_bank_id'];
//     verbalBankBranchId = json['verbal_bank_branch_id'];
//     verbalBankContact = json['verbal_bank_contact'];
//     verbalOwner = json['verbal_owner'];
//     verbalContact = json['verbal_contact'];
//     verbalDate = json['verbal_date'];
//     verbalBankOfficer = json['verbal_bank_officer'];
//     verbalAddress = json['verbal_address'];
//     verbalProvinceId = json['verbal_province_id'];
//     verbalDistrictId = json['verbal_district_id'];
//     verbalCommuneId = json['verbal_commune_id'];
//     verbalApproveId = json['verbal_approve_id'];
//     verbalApprovesId = json['verbal_approves_id'];
//     verbalComment = json['verbal_comment'];
//     verbalImage = json['verbal_image'];
//     latlongLog = json['latlong_log'];
//     latlongLa = json['latlong_la'];
//     verbalCom = json['verbal_com'];
//     verbalCon = json['verbal_con'];
//     verbalOption = json['verbal_option'];
//     verbalStatusId = json['verbal_status_id'];
//     verbalPublished = json['verbal_published'];
//     verbalUser = json['verbal_user'];
//     verbalComp = json['verbal_comp'];
//     verifyAgent = json['VerifyAgent'];
//     verbalCreatedBy = json['verbal_created_by'];
//     verbalCreatedDate = json['verbal_created_date'];
//     verbalModifyBy = json['verbal_modify_by'];
//   }

//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['verbal_id'] = this.verbalId;
//     data['verbal_property_id'] = this.verbalPropertyId;
//     data['verbal_property_code'] = this.verbalPropertyCode;
//     data['verbal_bank_id'] = this.verbalBankId;
//     data['verbal_bank_branch_id'] = this.verbalBankBranchId;
//     data['verbal_bank_contact'] = this.verbalBankContact;
//     data['verbal_owner'] = this.verbalOwner;
//     data['verbal_contact'] = this.verbalContact;
//     data['verbal_date'] = this.verbalDate;
//     data['verbal_bank_officer'] = this.verbalBankOfficer;
//     data['verbal_address'] = this.verbalAddress;
//     data['verbal_province_id'] = this.verbalProvinceId;
//     data['verbal_district_id'] = this.verbalDistrictId;
//     data['verbal_commune_id'] = this.verbalCommuneId;
//     data['verbal_approve_id'] = this.verbalApproveId;
//     data['verbal_approves_id'] = this.verbalApprovesId;
//     data['verbal_comment'] = this.verbalComment;
//     data['verbal_image'] = this.verbalImage;
//     data['latlong_log'] = this.latlongLog;
//     data['latlong_la'] = this.latlongLa;
//     data['verbal_com'] = this.verbalCom;
//     data['verbal_con'] = this.verbalCon;
//     data['verbal_option'] = this.verbalOption;
//     data['verbal_status_id'] = this.verbalStatusId;
//     data['verbal_published'] = this.verbalPublished;
//     data['verbal_user'] = this.verbalUser;
//     data['verbal_comp'] = this.verbalComp;
//     data['VerifyAgent'] = this.verifyAgent;
//     data['verbal_created_by'] = this.verbalCreatedBy;
//     data['verbal_created_date'] = this.verbalCreatedDate;
//     data['verbal_modify_by'] = this.verbalModifyBy;
//     return data;
//   }
// }
