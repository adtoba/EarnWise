class CreateReviewRequest {
  String? review;
  double? rating;
  String? expertId;
  String? expertProfilePic;

  CreateReviewRequest({
    this.review,
    this.rating,
    this.expertId,
    this.expertProfilePic,
  });

  CreateReviewRequest.fromJson(Map<String, dynamic> json) {
    review = json['review'];
    rating = json['rating'];
    expertId = json['expertId'];
    expertProfilePic = json['expertProfilePic'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['review'] = review;
    data['rating'] = rating;
    data['expertId'] = expertId;
    data['expertProfilePic'] = expertProfilePic;
    return data;
  }
}
