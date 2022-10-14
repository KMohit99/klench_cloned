class M_ScreenWeeklyDataModel {
  List<Data>? data;
  bool? error;
  String? statusCode;
  String? message;

  M_ScreenWeeklyDataModel(
      {this.data, this.error, this.statusCode, this.message});

  M_ScreenWeeklyDataModel.fromJson(Map<String, dynamic> json) {
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
  String? createdDate;
  List<Days>? days;

  Data({this.createdDate, this.days});

  Data.fromJson(Map<String, dynamic> json) {
    createdDate = json['createdDate'];
    if (json['days'] != null) {
      days = <Days>[];
      json['days'].forEach((v) {
        days!.add(new Days.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdDate'] = this.createdDate;
    if (this.days != null) {
      data['days'] = this.days!.map((v) => v.toJson()).toList();
    }
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
    data['sets'] = this.sets;
    data['numberOf_sets'] = this.numberOfSets;
    data['colorCode'] = this.colorCode;
    data['createdDate'] = this.createdDate;
    return data;
  }
}