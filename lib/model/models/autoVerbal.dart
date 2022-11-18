class autoverbal {
  String? verbalId;
  String? verbalPropertyId;
  String? verbalPropertyCode;
  String? verbalBankId;
  String? verbalBankBranchId;
  String? verbalBankContact;
  String? verbalOwner;
  String? verbalContact;
  String? verbalDate;
  String? verbalBankOfficer;
  String? verbalAddress;
  Null? verbalProvinceId;
  Null? verbalDistrictId;
  Null? verbalCommuneId;
  String? verbalApproveId;
  Null? verbalApprovesId;
  String? verbalComment;
  Null? verbalImage;
  String? latlongLog;
  String? latlongLa;
  Null? verbalCom;
  Null? verbalCon;
  String? verbalOption;
  String? verbalStatusId;
  String? verbalPublished;
  String? verbalUser;
  String? verbalComp;
  Null? verifyAgent;
  Null? verbalCreatedBy;
  String? verbalCreatedDate;
  Null? verbalModifyBy;
  Null? propertyTypeId;
  Null? propertyTypeName;
  Null? propertyTypePublished;
  Null? propertyTypeColor;
  Null? propertyColos;
  Null? propertyTypeCreatedBy;
  Null? propertyTypeCreatedDate;
  Null? propertyTypeModifyBy;
  Null? propertyTypeModifyDate;
  String? bankId;
  String? bankAcronym;
  String? bankName;
  Null? bankofficer;
  String? bankcontact;
  Null? bankProvinceId;
  Null? bankDistrictId;
  Null? bankCommuneId;
  String? bankVillage;
  String? bankPublished;
  Null? bankCreatedBy;
  String? bankCreatedDate;
  Null? bankModifyBy;
  Null? bankModifyDate;
  String? approveId;
  String? approveName;
  String? approvePublished;
  Null? approveCreatedBy;
  String? approveCreatedDate;
  Null? approveModifyBy;
  Null? agenttypeId;
  Null? agenttypeName;
  Null? agentTypePhone;
  Null? agentTypeEmail;
  Null? agenttypePublished;
  Null? agenttypeCreatedBy;
  Null? agenttypeCreatedDate;
  Null? agenttypeModifyBy;
  Null? agenttypeModifyDate;

  autoverbal(
      {this.verbalId,
      this.verbalPropertyId,
      this.verbalPropertyCode,
      this.verbalBankId,
      this.verbalBankBranchId,
      this.verbalBankContact,
      this.verbalOwner,
      this.verbalContact,
      this.verbalDate,
      this.verbalBankOfficer,
      this.verbalAddress,
      this.verbalProvinceId,
      this.verbalDistrictId,
      this.verbalCommuneId,
      this.verbalApproveId,
      this.verbalApprovesId,
      this.verbalComment,
      this.verbalImage,
      this.latlongLog,
      this.latlongLa,
      this.verbalCom,
      this.verbalCon,
      this.verbalOption,
      this.verbalStatusId,
      this.verbalPublished,
      this.verbalUser,
      this.verbalComp,
      this.verifyAgent,
      this.verbalCreatedBy,
      this.verbalCreatedDate,
      this.verbalModifyBy,
      this.propertyTypeId,
      this.propertyTypeName,
      this.propertyTypePublished,
      this.propertyTypeColor,
      this.propertyColos,
      this.propertyTypeCreatedBy,
      this.propertyTypeCreatedDate,
      this.propertyTypeModifyBy,
      this.propertyTypeModifyDate,
      this.bankId,
      this.bankAcronym,
      this.bankName,
      this.bankofficer,
      this.bankcontact,
      this.bankProvinceId,
      this.bankDistrictId,
      this.bankCommuneId,
      this.bankVillage,
      this.bankPublished,
      this.bankCreatedBy,
      this.bankCreatedDate,
      this.bankModifyBy,
      this.bankModifyDate,
      this.approveId,
      this.approveName,
      this.approvePublished,
      this.approveCreatedBy,
      this.approveCreatedDate,
      this.approveModifyBy,
      this.agenttypeId,
      this.agenttypeName,
      this.agentTypePhone,
      this.agentTypeEmail,
      this.agenttypePublished,
      this.agenttypeCreatedBy,
      this.agenttypeCreatedDate,
      this.agenttypeModifyBy,
      this.agenttypeModifyDate});

  factory autoverbal.fromJson(Map<String, dynamic> json) => autoverbal(
        verbalId: json['verbal_id'],
        verbalPropertyId: json['verbal_property_id'],
        verbalPropertyCode: json['verbal_property_code'],
        verbalBankId: json['verbal_bank_id'],
        verbalBankBranchId: json['verbal_bank_branch_id'],
        verbalBankContact: json['verbal_bank_contact'],
        verbalOwner: json['verbal_owner'],
        verbalContact: json['verbal_contact'],
        verbalDate: json['verbal_date'],
        verbalBankOfficer: json['verbal_bank_officer'],
        verbalAddress: json['verbal_address'],
        verbalProvinceId: json['verbal_province_id'],
        verbalDistrictId: json['verbal_district_id'],
        verbalCommuneId: json['verbal_commune_id'],
        verbalApproveId: json['verbal_approve_id'],
        verbalApprovesId: json['verbal_approves_id'],
        verbalComment: json['verbal_comment'],
        verbalImage: json['verbal_image'],
        latlongLog: json['latlong_log'],
        latlongLa: json['latlong_la'],
        verbalCom: json['verbal_com'],
        verbalCon: json['verbal_con'],
        verbalOption: json['verbal_option'],
        verbalStatusId: json['verbal_status_id'],
        verbalPublished: json['verbal_published'],
        verbalUser: json['verbal_user'],
        verbalComp: json['verbal_comp'],
        verifyAgent: json['VerifyAgent'],
        verbalCreatedBy: json['verbal_created_by'],
        verbalCreatedDate: json['verbal_created_date'],
        verbalModifyBy: json['verbal_modify_by'],
        propertyTypeId: json['property_type_id'],
        propertyTypeName: json['property_type_name'],
        propertyTypePublished: json['property_type_published'],
        propertyTypeColor: json['property_type_color'],
        propertyColos: json['property_colos'],
        propertyTypeCreatedBy: json['property_type_created_by'],
        propertyTypeCreatedDate: json['property_type_created_date'],
        propertyTypeModifyBy: json['property_type_modify_by'],
        propertyTypeModifyDate: json['property_type_modify_date'],
        bankId: json['bank_id'],
        bankAcronym: json['bank_acronym'],
        bankName: json['bank_name'],
        bankofficer: json['bankofficer'],
        bankcontact: json['bankcontact'],
        bankProvinceId: json['bank_province_id'],
        bankDistrictId: json['bank_district_id'],
        bankCommuneId: json['bank_commune_id'],
        bankVillage: json['bank_village'],
        bankPublished: json['bank_published'],
        bankCreatedBy: json['bank_created_by'],
        bankCreatedDate: json['bank_created_date'],
        bankModifyBy: json['bank_modify_by'],
        bankModifyDate: json['bank_modify_date'],
        approveId: json['approve_id'],
        approveName: json['approve_name'],
        approvePublished: json['approve_published'],
        approveCreatedBy: json['approve_created_by'],
        approveCreatedDate: json['approve_created_date'],
        approveModifyBy: json['approve_modify_by'],
        agenttypeId: json['agenttype_id'],
        agenttypeName: json['agenttype_name'],
        agentTypePhone: json['agent_type_phone'],
        agentTypeEmail: json['agent_type_email'],
        agenttypePublished: json['agenttype_published'],
        agenttypeCreatedBy: json['agenttype_created_by'],
        agenttypeCreatedDate: json['agenttype_created_date'],
        agenttypeModifyBy: json['agenttype_modify_by'],
        agenttypeModifyDate: json['agenttype_modify_date'],
      );

  Map<String, dynamic> toJson() => {
        'verbal_id': this.verbalId,
        'verbal_property_id': this.verbalPropertyId,
        'verbal_property_code': this.verbalPropertyCode,
        'verbal_bank_id': this.verbalBankId,
        'verbal_bank_branch_id': this.verbalBankBranchId,
        'verbal_bank_contact': this.verbalBankContact,
        'verbal_owner': this.verbalOwner,
        'verbal_contact': this.verbalContact,
        'verbal_date': this.verbalDate,
        'verbal_bank_officer': this.verbalBankOfficer,
        'verbal_address': this.verbalAddress,
        'verbal_province_id': this.verbalProvinceId,
        'verbal_district_id': this.verbalDistrictId,
        'verbal_commune_id': this.verbalCommuneId,
        'verbal_approve_id': this.verbalApproveId,
        'verbal_approves_id': this.verbalApprovesId,
        'verbal_comment': this.verbalComment,
        'verbal_image': this.verbalImage,
        'latlong_log': this.latlongLog,
        'latlong_la': this.latlongLa,
        'verbal_com': this.verbalCom,
        'verbal_con': this.verbalCon,
        'verbal_option': this.verbalOption,
        'verbal_status_id': this.verbalStatusId,
        'verbal_published': this.verbalPublished,
        'verbal_user': this.verbalUser,
        'verbal_comp': this.verbalComp,
        'VerifyAgent': this.verifyAgent,
        'verbal_created_by': this.verbalCreatedBy,
        'verbal_created_date': this.verbalCreatedDate,
        'verbal_modify_by': this.verbalModifyBy,
        'property_type_id': this.propertyTypeId,
        'property_type_name': this.propertyTypeName,
        'property_type_published': this.propertyTypePublished,
        'property_type_color': this.propertyTypeColor,
        'property_colos': this.propertyColos,
        'property_type_created_by': this.propertyTypeCreatedBy,
        'property_type_created_date': this.propertyTypeCreatedDate,
        'property_type_modify_by': this.propertyTypeModifyBy,
        'property_type_modify_date': this.propertyTypeModifyDate,
        'bank_id': this.bankId,
        'bank_acronym': this.bankAcronym,
        'bank_name': this.bankName,
        'bankofficer': this.bankofficer,
        'bankcontact': this.bankcontact,
        'bank_province_id': this.bankProvinceId,
        'bank_district_id': this.bankDistrictId,
        'bank_commune_id': this.bankCommuneId,
        'bank_village': this.bankVillage,
        'bank_published': this.bankPublished,
        'bank_created_by': this.bankCreatedBy,
        'bank_created_date': this.bankCreatedDate,
        'bank_modify_by': this.bankModifyBy,
        'bank_modify_date': this.bankModifyDate,
        'approve_id': this.approveId,
        'approve_name': this.approveName,
        'approve_published': this.approvePublished,
        'approve_created_by': this.approveCreatedBy,
        'approve_created_date': this.approveCreatedDate,
        'approve_modify_by': this.approveModifyBy,
        'agenttype_id': this.agenttypeId,
        'agenttype_name': this.agenttypeName,
        'agent_type_phone': this.agentTypePhone,
        'agent_type_email': this.agentTypeEmail,
        'agenttype_published': this.agenttypePublished,
        'agenttype_created_by': this.agenttypeCreatedBy,
        'agenttype_created_date': this.agenttypeCreatedDate,
        'agenttype_modify_by': this.agenttypeModifyBy,
        'agenttype_modify_date': this.agenttypeModifyDate,
      };
}

// class Autogenerated {
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
//   Null? verbalProvinceId;
//   Null? verbalDistrictId;
//   Null? verbalCommuneId;
//   String? verbalApproveId;
//   Null? verbalApprovesId;
//   String? verbalComment;
//   Null? verbalImage;
//   String? latlongLog;
//   String? latlongLa;
//   Null? verbalCom;
//   Null? verbalCon;
//   String? verbalOption;
//   String? verbalStatusId;
//   String? verbalPublished;
//   String? verbalUser;
//   String? verbalComp;
//   Null? verifyAgent;
//   Null? verbalCreatedBy;
//   String? verbalCreatedDate;
//   Null? verbalModifyBy;
//   Null? propertyTypeId;
//   Null? propertyTypeName;
//   Null? propertyTypePublished;
//   Null? propertyTypeColor;
//   Null? propertyColos;
//   Null? propertyTypeCreatedBy;
//   Null? propertyTypeCreatedDate;
//   Null? propertyTypeModifyBy;
//   Null? propertyTypeModifyDate;
//   String? bankId;
//   String? bankAcronym;
//   String? bankName;
//   Null? bankofficer;
//   String? bankcontact;
//   Null? bankProvinceId;
//   Null? bankDistrictId;
//   Null? bankCommuneId;
//   String? bankVillage;
//   String? bankPublished;
//   Null? bankCreatedBy;
//   String? bankCreatedDate;
//   Null? bankModifyBy;
//   Null? bankModifyDate;
//   String? approveId;
//   String? approveName;
//   String? approvePublished;
//   Null? approveCreatedBy;
//   String? approveCreatedDate;
//   Null? approveModifyBy;
//   Null? agenttypeId;
//   Null? agenttypeName;
//   Null? agentTypePhone;
//   Null? agentTypeEmail;
//   Null? agenttypePublished;
//   Null? agenttypeCreatedBy;
//   Null? agenttypeCreatedDate;
//   Null? agenttypeModifyBy;
//   Null? agenttypeModifyDate;

//   Autogenerated(
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
//       this.verbalModifyBy,
//       this.propertyTypeId,
//       this.propertyTypeName,
//       this.propertyTypePublished,
//       this.propertyTypeColor,
//       this.propertyColos,
//       this.propertyTypeCreatedBy,
//       this.propertyTypeCreatedDate,
//       this.propertyTypeModifyBy,
//       this.propertyTypeModifyDate,
//       this.bankId,
//       this.bankAcronym,
//       this.bankName,
//       this.bankofficer,
//       this.bankcontact,
//       this.bankProvinceId,
//       this.bankDistrictId,
//       this.bankCommuneId,
//       this.bankVillage,
//       this.bankPublished,
//       this.bankCreatedBy,
//       this.bankCreatedDate,
//       this.bankModifyBy,
//       this.bankModifyDate,
//       this.approveId,
//       this.approveName,
//       this.approvePublished,
//       this.approveCreatedBy,
//       this.approveCreatedDate,
//       this.approveModifyBy,
//       this.agenttypeId,
//       this.agenttypeName,
//       this.agentTypePhone,
//       this.agentTypeEmail,
//       this.agenttypePublished,
//       this.agenttypeCreatedBy,
//       this.agenttypeCreatedDate,
//       this.agenttypeModifyBy,
//       this.agenttypeModifyDate});

//   Autogenerated.fromJson(Map<String, dynamic> json) {
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
//     propertyTypeId = json['property_type_id'];
//     propertyTypeName = json['property_type_name'];
//     propertyTypePublished = json['property_type_published'];
//     propertyTypeColor = json['property_type_color'];
//     propertyColos = json['property_colos'];
//     propertyTypeCreatedBy = json['property_type_created_by'];
//     propertyTypeCreatedDate = json['property_type_created_date'];
//     propertyTypeModifyBy = json['property_type_modify_by'];
//     propertyTypeModifyDate = json['property_type_modify_date'];
//     bankId = json['bank_id'];
//     bankAcronym = json['bank_acronym'];
//     bankName = json['bank_name'];
//     bankofficer = json['bankofficer'];
//     bankcontact = json['bankcontact'];
//     bankProvinceId = json['bank_province_id'];
//     bankDistrictId = json['bank_district_id'];
//     bankCommuneId = json['bank_commune_id'];
//     bankVillage = json['bank_village'];
//     bankPublished = json['bank_published'];
//     bankCreatedBy = json['bank_created_by'];
//     bankCreatedDate = json['bank_created_date'];
//     bankModifyBy = json['bank_modify_by'];
//     bankModifyDate = json['bank_modify_date'];
//     approveId = json['approve_id'];
//     approveName = json['approve_name'];
//     approvePublished = json['approve_published'];
//     approveCreatedBy = json['approve_created_by'];
//     approveCreatedDate = json['approve_created_date'];
//     approveModifyBy = json['approve_modify_by'];
//     agenttypeId = json['agenttype_id'];
//     agenttypeName = json['agenttype_name'];
//     agentTypePhone = json['agent_type_phone'];
//     agentTypeEmail = json['agent_type_email'];
//     agenttypePublished = json['agenttype_published'];
//     agenttypeCreatedBy = json['agenttype_created_by'];
//     agenttypeCreatedDate = json['agenttype_created_date'];
//     agenttypeModifyBy = json['agenttype_modify_by'];
//     agenttypeModifyDate = json['agenttype_modify_date'];
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
//     data['property_type_id'] = this.propertyTypeId;
//     data['property_type_name'] = this.propertyTypeName;
//     data['property_type_published'] = this.propertyTypePublished;
//     data['property_type_color'] = this.propertyTypeColor;
//     data['property_colos'] = this.propertyColos;
//     data['property_type_created_by'] = this.propertyTypeCreatedBy;
//     data['property_type_created_date'] = this.propertyTypeCreatedDate;
//     data['property_type_modify_by'] = this.propertyTypeModifyBy;
//     data['property_type_modify_date'] = this.propertyTypeModifyDate;
//     data['bank_id'] = this.bankId;
//     data['bank_acronym'] = this.bankAcronym;
//     data['bank_name'] = this.bankName;
//     data['bankofficer'] = this.bankofficer;
//     data['bankcontact'] = this.bankcontact;
//     data['bank_province_id'] = this.bankProvinceId;
//     data['bank_district_id'] = this.bankDistrictId;
//     data['bank_commune_id'] = this.bankCommuneId;
//     data['bank_village'] = this.bankVillage;
//     data['bank_published'] = this.bankPublished;
//     data['bank_created_by'] = this.bankCreatedBy;
//     data['bank_created_date'] = this.bankCreatedDate;
//     data['bank_modify_by'] = this.bankModifyBy;
//     data['bank_modify_date'] = this.bankModifyDate;
//     data['approve_id'] = this.approveId;
//     data['approve_name'] = this.approveName;
//     data['approve_published'] = this.approvePublished;
//     data['approve_created_by'] = this.approveCreatedBy;
//     data['approve_created_date'] = this.approveCreatedDate;
//     data['approve_modify_by'] = this.approveModifyBy;
//     data['agenttype_id'] = this.agenttypeId;
//     data['agenttype_name'] = this.agenttypeName;
//     data['agent_type_phone'] = this.agentTypePhone;
//     data['agent_type_email'] = this.agentTypeEmail;
//     data['agenttype_published'] = this.agenttypePublished;
//     data['agenttype_created_by'] = this.agenttypeCreatedBy;
//     data['agenttype_created_date'] = this.agenttypeCreatedDate;
//     data['agenttype_modify_by'] = this.agenttypeModifyBy;
//     data['agenttype_modify_date'] = this.agenttypeModifyDate;
//     return data;
//   }
// }
