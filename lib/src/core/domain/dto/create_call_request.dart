class CreateCallRequest {
  String? reason;
  String? expertName;
  String? expertId;
  String? expertProfilePic;
  int? hourlyRate;
  List<String>? suggestedTimes;
  int? totalMinutes;

  CreateCallRequest(
      {this.reason,
      this.expertName,
      this.expertId,
      this.expertProfilePic,
      this.hourlyRate,
      this.suggestedTimes,
      this.totalMinutes});

  CreateCallRequest.fromJson(Map<String, dynamic> json) {
    reason = json['reason'];
    expertName = json['expertName'];
    expertId = json['expertId'];
    expertProfilePic = json['expertProfilePic'];
    hourlyRate = json['hourlyRate'];
    suggestedTimes = json['suggestedTimes'].cast<String>();
    totalMinutes = json['totalMinutes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['reason'] = reason;
    data['expertName'] = expertName;
    data['expertId'] = expertId;
    data['expertProfilePic'] = expertProfilePic;
    data['hourlyRate'] = hourlyRate;
    data['suggestedTimes'] = suggestedTimes;
    data['totalMinutes'] = totalMinutes;
    return data;
  }
}
