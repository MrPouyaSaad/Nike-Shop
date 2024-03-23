class Bannermodel {
  final String imageUrl;
  final int id;

  Bannermodel.fromJson(Map<String, dynamic> json)
      : imageUrl = json['image'],
        id = json['id'];
}
