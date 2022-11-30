class GetMasturbationMethod {
  bool? error;
  String? statusCode;
  String? message;
  List<Data>? data;

  GetMasturbationMethod({this.error, this.statusCode, this.message, this.data});

  GetMasturbationMethod.fromJson(Map<String, dynamic> json) {
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
  String? methodName;
  String? colorCode;
  String? createdDate;
  String? updatedDate;

  Data(
      {this.id,
        this.userId,
        this.methodName,
        this.colorCode,
        this.createdDate,
        this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    methodName = json['method_name'];
    colorCode = json['color_code'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['method_name'] = this.methodName;
    data['color_code'] = this.colorCode;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}