class CreateReviewRequest {
  String? review;
  double? rating;
  String? expertId;
  String? expertProfilePic;
  String? userProfileId;
  String? userProfilePic;

  CreateReviewRequest({
    this.review,
    this.rating,
    this.expertId,
    this.expertProfilePic,
    this.userProfileId,
    this.userProfilePic
  });

  CreateReviewRequest.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    rating = json['rating'];
    expertId = json['expertId'];
    expertProfilePic = json['expertProfilePic'];
    userProfilePic = json['userProfilePic'];
    userProfileId = json['userProfileId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review'] = review;
    data['rating'] = rating;
    data['expertId'] = expertId;
    data['expertProfilePic'] = expertProfilePic;
    data['userProfileId'] = userProfileId;
    data['userProfilePic'] = userProfilePic;
    return data;
  }
}
