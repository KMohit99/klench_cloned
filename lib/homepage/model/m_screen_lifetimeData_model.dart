class M_ScreenLifeTimeDataModel {
  List<Data>? data;
  bool? error;
  String? statusCode;
  String? message;

  M_ScreenLifeTimeDataModel(
      {this.data, this.error, this.statusCode, this.message});

  M_ScreenLifeTimeDataModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    error = json['error'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['error'] = this.error;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? fullName;
  String? username;
  String? image;
  User? user;
  List<Methods>? methods;

  Data(
      {this.id,
        this.fullName,
        this.username,
        this.image,
        this.user,
        this.methods});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    image = json['image'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['methods'] != null) {
      methods = <Methods>[];
      json['methods'].forEach((v) {
        methods!.add(new Methods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['username'] = this.username;
    data['image'] = this.image;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    if (this.methods != null) {
      data['methods'] = this.methods!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  String? fullName;
  String? username;
  String? phone;
  String? countryCode;
  String? email;
  String? gender;
  String? image;
  String? levels;
  String? type;

  User(
      {this.id,
        this.fullName,
        this.username,
        this.phone,
        this.countryCode,
        this.email,
        this.gender,
        this.image,
        this.levels,
        this.type});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    phone = json['phone'];
    countryCode = json['countryCode'];
    email = json['email'];
    gender = json['gender'];
    image = json['image'];
    levels = json['levels'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['fullName'] = this.fullName;
    data['username'] = this.username;
    data['phone'] = this.phone;
    data['countryCode'] = this.countryCode;
    data['email'] = this.email;
    data['gender'] = this.gender;
    data['image'] = this.image;
    data['levels'] = this.levels;
    data['type'] = this.type;
    return data;
  }
}

class Methods {
  String? id;
  String? userId;
  String? mbId;
  String? methodName;
  String? pauses;
  String? totalPauses;
  String? totalTime;
  String? sets;
  String? numberOfSets;
  String? createdDate;
  String? updatedDate;

  Methods(
      {this.id,
        this.userId,
        this.mbId,
        this.methodName,
        this.pauses,
        this.totalPauses,
        this.totalTime,
        this.sets,
        this.numberOfSets,
        this.createdDate,
        this.updatedDate});

  Methods.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    mbId = json['mbId'];
    methodName = json['methodName'];
    pauses = json['pauses'];
    totalPauses = json['totalPauses'];
    totalTime = json['totalTime'];
    sets = json['sets'];
    numberOfSets = json['numberOf_sets'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['mbId'] = this.mbId;
    data['methodName'] = this.methodName;
    data['pauses'] = this.pauses;
    data['totalPauses'] = this.totalPauses;
    data['totalTime'] = this.totalTime;
    data['sets'] = this.sets;
    data['numberOf_sets'] = this.numberOfSets;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}