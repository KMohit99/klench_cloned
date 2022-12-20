class KegelGetAlarmModel {
  bool? error;
  String? statusCode;
  String? message;
  List<Data>? data;

  KegelGetAlarmModel({this.error, this.statusCode, this.message, this.data});

  KegelGetAlarmModel.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    statusCode = json['status_code'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['error'] = this.error;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? alarmTime;
  String? createdDate;

  Data({this.id, this.userId, this.alarmTime, this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['userId'];
    alarmTime = json['alarmTime'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['userId'] = this.userId;
    data['alarmTime'] = this.alarmTime;
    data['createdDate'] = this.createdDate;
    return data;
  }
}