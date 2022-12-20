class GetStartEndModel {
  Data? data;
  bool? error;
  String? statusCode;
  String? message;

  GetStartEndModel({this.data, this.error, this.statusCode, this.message});

  GetStartEndModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    error = json['error'];
    statusCode = json['status_code'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['error'] = this.error;
    data['status_code'] = this.statusCode;
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? userId;
  String? startTime;
  String? endTime;
  String? createdDate;
  String? updatedDate;

  Data(
      {this.id,
        this.userId,
        this.startTime,
        this.endTime,
        this.createdDate,
        this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['start_time'] = this.startTime;
    data['end_time'] = this.endTime;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}