class GetTechniqueModel {
  bool? error;
  String? statusCode;
  String? message;
  Data? data;

  GetTechniqueModel({this.error, this.statusCode, this.message, this.data});

  GetTechniqueModel.fromJson(Map<String, dynamic> json) {
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
  String? userId;
  String? exerciseName;
  String? technique;
  String? createdDate;
  String? updatedDate;

  Data(
      {this.id,
        this.userId,
        this.exerciseName,
        this.technique,
        this.createdDate,
        this.updatedDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    exerciseName = json['exercise_name'];
    technique = json['technique'];
    createdDate = json['createdDate'];
    updatedDate = json['updatedDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['exercise_name'] = this.exerciseName;
    data['technique'] = this.technique;
    data['createdDate'] = this.createdDate;
    data['updatedDate'] = this.updatedDate;
    return data;
  }
}