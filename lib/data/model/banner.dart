class BannerModel {
  final String imageUrl;
  final int id;

  BannerModel.fromJson(Map<String, dynamic> json)
      : imageUrl = json['image'],
        id = json['id'];
}
