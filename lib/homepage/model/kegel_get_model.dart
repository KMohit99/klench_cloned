class KegelGetModel {
  List<Data>? data;
  bool? error;
  String? statusCode;
  String? message;

  KegelGetModel({this.data, this.error, this.statusCode, this.message});

  KegelGetModel.fromJson(Map<String, dynamic> json) {
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
  String? sets;
  String? startTime;
  String? finishTime;
  String? pause;
  String? alarm;
  String? repeate;
  String? label;
  String? sound;
  String? kegelInfo;
  String? numberOfSets;
  String? createdDate;

  Data(
      {this.id,
        this.sets,
        this.startTime,
        this.finishTime,
        this.pause,
        this.alarm,
        this.repeate,
        this.label,
        this.sound,
        this.kegelInfo,
        this.numberOfSets,
        this.createdDate});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sets = json['sets'];
    startTime = json['startTime'];
    finishTime = json['finishTime'];
    pause = json['pause'];
    alarm = json['alarm'];
    repeate = json['repeate'];
    label = json['label'];
    sound = json['sound'];
    kegelInfo = json['kegel_info'];
    numberOfSets = json['numberOf_sets'];
    createdDate = json['createdDate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['sets'] = this.sets;
    data['startTime'] = this.startTime;
    data['finishTime'] = this.finishTime;
    data['pause'] = this.pause;
    data['alarm'] = this.alarm;
    data['repeate'] = this.repeate;
    data['label'] = this.label;
    data['sound'] = this.sound;
    data['kegel_info'] = this.kegelInfo;
    data['numberOf_sets'] = this.numberOfSets;
    data['createdDate'] = this.createdDate;
    return data;
  }
}