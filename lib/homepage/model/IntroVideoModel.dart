class IntroVideoModel {
  List<Data>? data;
  bool? error;
  String? statusCode;
  String? message;

  IntroVideoModel({this.data, this.error, this.statusCode, this.message});

  IntroVideoModel.fromJson(Map<String, dynamic> json) {
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
  String? title;
  String? uploadVideo;
  String? createdDate;

  Data({this.id, this.title, this.uploadVideo, this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    uploadVideo = json['uploadVideo'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['uploadVideo'] = this.uploadVideo;
    data['createdDate'] = this.createdDate;
    return data;
  }
}