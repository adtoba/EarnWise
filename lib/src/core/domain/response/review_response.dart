class ReviewResponse {
  String? id;
  String? review;
  String? expertId;
  String? userId;
  String? expertProfilePic;
  String? userProfilePic;
  double? rating;
  String? userProfileId;
  String? createdAt;
  String? updatedAt;

  ReviewResponse(
      {this.id,
      this.review,
      this.expertId,
      this.userId,
      this.expertProfilePic,
      this.userProfilePic,
      this.rating,
      this.userProfileId,
      this.createdAt,
      this.updatedAt});

  ReviewResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    review = json['review'];
    expertId = json['expertId'];
    userId = json['userId'];
    expertProfilePic = json['expertProfilePic'];
    userProfilePic = json['userProfilePic'];
    rating = json['rating'];
    userProfileId = json['userProfileId'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['review'] = review;
    data['expertId'] = expertId;
    data['userId'] = userId;
    data['expertProfilePic'] = expertProfilePic;
    data['userProfilePic'] = userProfilePic;
    data['rating'] = rating;
    data['userProfileId'] = userProfileId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
