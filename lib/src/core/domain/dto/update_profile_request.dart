class UpdateProfileRequest {
  String? professionalTitle;
  String? location;
  String? timezone;
  String? bio;
  String? phoneNumber;
  List<String>? interests;

  UpdateProfileRequest(
      {this.professionalTitle,
      this.location,
      this.timezone,
      this.bio,
      this.phoneNumber,
      this.interests});

  UpdateProfileRequest.fromJson(Map<String, dynamic> json) {
    professionalTitle = json['professionalTitle'];
    location = json['location'];
    timezone = json['timezone'];
    bio = json['bio'];
    phoneNumber = json['phoneNumber'];
    interests = json['interests'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['professionalTitle'] = professionalTitle;
    data['location'] = location;
    data['timezone'] = timezone;
    data['bio'] = bio;
    data['phoneNumber'] = phoneNumber;
    data['interests'] = interests;
    return data;
  }
}
