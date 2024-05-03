class CallResponse {
  String? id;
  String? reason;
  String? status;
  String? expertId;
  String? expertProfilePic;
  String? userId;
  String? userProfilePic;
  String? acceptedTime;
  String? cancelReason;
  int? totalMinutes;
  double? hourlyRate;
  List<String>? suggestedTimes;
  String? createdAt;
  String? updatedAt;
  bool? paid;

  CallResponse(
      {this.id,
      this.reason,
      this.status,
      this.expertId,
      this.expertProfilePic,
      this.userId,
      this.userProfilePic,
      this.acceptedTime,
      this.cancelReason,
      this.totalMinutes,
      this.hourlyRate,
      this.suggestedTimes,
      this.createdAt,
      this.updatedAt,
      this.paid});

  CallResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    reason = json['reason'];
    status = json['status'];
    expertId = json['expertId'];
    expertProfilePic = json['expertProfilePic'];
    userId = json['userId'];
    userProfilePic = json['userProfilePic'];
    acceptedTime = json['acceptedTime'];
    cancelReason = json['cancelReason'];
    totalMinutes = json['totalMinutes'];
    hourlyRate = json['hourlyRate'];
    suggestedTimes = json['suggestedTimes'].cast<String>();
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    paid = json['paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['reason'] = reason;
    data['status'] = status;
    data['expertId'] = expertId;
    data['expertProfilePic'] = expertProfilePic;
    data['userId'] = userId;
    data['userProfilePic'] = userProfilePic;
    data['acceptedTime'] = acceptedTime;
    data['cancelReason'] = cancelReason;
    data['totalMinutes'] = totalMinutes;
    data['hourlyRate'] = hourlyRate;
    data['suggestedTimes'] = suggestedTimes;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['paid'] = paid;
    return data;
  }
}
