class ExpertProfile {
  String? id;
  String? title;
  String? description;
  String? fullName;
  String? coverImage;
  String? category;
  String? userId;
  int? totalReviews;
  int? totalRatings;
  double? ratings;
  List<String>? topics;
  double? hourlyRate;
  String? createdAt;
  String? updatedAt;

  ExpertProfile(
      {this.id,
      this.title,
      this.description,
      this.fullName,
      this.coverImage,
      this.category,
      this.userId,
      this.totalReviews,
      this.totalRatings,
      this.ratings,
      this.topics,
      this.hourlyRate,
      this.createdAt,
      this.updatedAt});

  ExpertProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    fullName = json["fullName"];
    coverImage = json['coverImage'];
    category = json['category'];
    userId = json['userId'];
    totalReviews = json['totalReviews'];
    totalRatings = json['totalRatings'];
    ratings = json['ratings'];
    topics = json['topics'].cast<String>();
    hourlyRate = json['hourlyRate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['fullName'] = fullName;
    data['coverImage'] = coverImage;
    data['category'] = category;
    data['userId'] = userId;
    data['totalReviews'] = totalReviews;
    data['totalRatings'] = totalRatings;
    data['ratings'] = ratings;
    data['topics'] = topics;
    data['hourlyRate'] = hourlyRate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    return data;
  }
}
