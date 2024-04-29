class CreateExpertProfileRequest {
  String? title;
  String? description;
  String? coverImage;
  String? category;
  String? userId;
  List<String>? topics;
  double? hourlyRate;

  CreateExpertProfileRequest(
      {this.title,
      this.description,
      this.coverImage,
      this.category,
      this.userId,
      this.topics,
      this.hourlyRate});

  CreateExpertProfileRequest.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    coverImage = json['coverImage'];
    category = json['category'];
    userId = json['userId'];
    topics = json['topics'].cast<String>();
    hourlyRate = json['hourlyRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['description'] = description;
    data['coverImage'] = coverImage;
    data['category'] = category;
    data['userId'] = userId;
    data['topics'] = topics;
    data['hourlyRate'] = hourlyRate;
    return data;
  }
}
