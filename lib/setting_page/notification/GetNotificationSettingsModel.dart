class GetNotificationSettingsModel {
  bool? error;
  String? statusCode;
  String? message;
  Data? data;

  GetNotificationSettingsModel(
      {this.error, this.statusCode, this.message, this.data});

  GetNotificationSettingsModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? pushNotification;
  String? addedApp;

  Data({this.userId, this.pushNotification, this.addedApp});

  Data.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    pushNotification = json['push_notification'];
    addedApp = json['added_app'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['push_notification'] = this.pushNotification;
    data['added_app'] = this.addedApp;
    return data;
  }
}