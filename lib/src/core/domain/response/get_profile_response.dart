import 'package:earnwise/src/core/domain/response/expert_profile.dart';

class GetProfileResponse {
  String? id;
  String? fullName;
  String? username;
  String? profilePic;
  String? professionalTitle;
  String? email;
  String? bio;
  String? location;
  String? timezone;
  String? phoneNumber;
  double? rating;
  int? totalRatings;
  int? totalCalls;
  List<String>? interests;
  ExpertProfile? expertProfile;
  String? createdAt;
  String? updatedAt;
  bool? verified;

  GetProfileResponse(
      {this.id,
      this.fullName,
      this.username,
      this.profilePic,
      this.professionalTitle,
      this.email,
      this.bio,
      this.location,
      this.timezone,
      this.phoneNumber,
      this.rating,
      this.totalRatings,
      this.totalCalls,
      this.interests,
      this.expertProfile,
      this.createdAt,
      this.updatedAt,
      this.verified});

  GetProfileResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    fullName = json['fullName'];
    username = json['username'];
    profilePic = json['profilePic'];
    professionalTitle = json['professionalTitle'];
    email = json['email'];
    bio = json['bio'];
    location = json['location'];
    timezone = json['timezone'];
    phoneNumber = json['phoneNumber'];
    rating = json['rating'];
    totalRatings = json['totalRatings'];
    totalCalls = json['totalCalls'];
    interests = json['interests'].cast<String>();
    expertProfile = json['expertProfile'] != null 
      ? ExpertProfile.fromJson(json['expertProfile'])
      : null;
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    verified = json['verified'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fullName'] = fullName;
    data['username'] = username;
    data['profilePic'] = profilePic;
    data['professionalTitle'] = professionalTitle;
    data['email'] = email;
    data['bio'] = bio;
    data['location'] = location;
    data['timezone'] = timezone;
    data['phoneNumber'] = phoneNumber;
    data['rating'] = rating;
    data['totalRatings'] = totalRatings;
    data['totalCalls'] = totalCalls;
    data['interests'] = interests;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['verified'] = verified;
    return data;
  }
}
