class M_ScreenDailyDataModel {
  List<Data>? data;
  bool? error;
  String? statusCode;
  String? message;

  M_ScreenDailyDataModel(
      {this.data, this.error, this.statusCode, this.message});

  M_ScreenDailyDataModel.fromJson(Map<String, dynamic> json) {
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
  List<Days>? days;

  Data(
      {this.id,
        this.fullName,
        this.username,
        this.image,
        this.user,
        this.days});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    image = json['image'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(new Days.fromJson(v));
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
    if (this.days != null) {
      data['days'] = this.days!.map((v) => v.toJson()).toList();
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

class Days {
  String? id;
  String? userId;
  String? methodName;
  String? pauses;
  String? totalPauses;
  String? totalTime;
  List<String>? pausesTime;
  String? sets;
  String? numberOfSets;
  String? colorCode;
  String? createdDate;

  Days(
      {this.id,
        this.userId,
        this.methodName,
        this.pauses,
        this.totalPauses,
        this.totalTime,
        this.pausesTime,
        this.sets,
        this.numberOfSets,
        this.colorCode,
        this.createdDate});

  Days.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    methodName = json['methodName'];
    pauses = json['pauses'];
    totalPauses = json['totalPauses'];
    totalTime = json['totalTime'];
    pausesTime = json['pauses_time'].cast<String>();
    sets = json['sets'];
    numberOfSets = json['numberOf_sets'];
    colorCode = json['colorCode'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['methodName'] = this.methodName;
    data['pauses'] = this.pauses;
    data['totalPauses'] = this.totalPauses;
    data['totalTime'] = this.totalTime;
    data['pauses_time'] = this.pausesTime;
    data['sets'] = this.sets;
    data['numberOf_sets'] = this.numberOfSets;
    data['colorCode'] = this.colorCode;
    data['createdDate'] = this.createdDate;
    return data;
  }
}