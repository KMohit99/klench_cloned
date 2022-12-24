class ForgotPasswordModel {
  bool? error;
  String? statusCode;
  String? message;
  Data? data;

  ForgotPasswordModel({this.error, this.statusCode, this.message, this.data});

  ForgotPasswordModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? id;
  String? fullName;
  String? username;
  String? phone;
  String? countryCode;
  String? email;
  String? dob;
  String? gender;
  String? image;
  String? levels;
  String? socialId;
  String? type;
  String? freeTrial;
  String? countTrial;
  String? status;
  String? timeZone;
  String? registerDate;

  Data(
      {this.id,
        this.fullName,
        this.username,
        this.phone,
        this.countryCode,
        this.email,
        this.dob,
        this.gender,
        this.image,
        this.levels,
        this.socialId,
        this.type,
        this.freeTrial,
        this.countTrial,
        this.status,
        this.timeZone,
        this.registerDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    email = json['email'];
    dob = json['dob'];
    gender = json['gender'];
    image = json['image'];
    levels = json['levels'];
    socialId = json['socialId'];
    type = json['type'];
    freeTrial = json['freeTrial'];
    countTrial = json['countTrial'];
    status = json['status'];
    timeZone = json['timeZone'];
    registerDate = json['register_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['countryCode'] = this.countryCode;
    data['email'] = this.email;
    data['dob'] = this.dob;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['levels'] = this.levels;
    data['socialId'] = this.socialId;
    data['type'] = this.type;
    data['freeTrial'] = this.freeTrial;
    data['countTrial'] = this.countTrial;
    data['status'] = this.status;
    data['timeZone'] = this.timeZone;
    data['register_date'] = this.registerDate;
    return data;
  }
}