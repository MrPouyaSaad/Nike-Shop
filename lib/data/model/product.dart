// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  int id;
  int price;
  String title;
  int discount;
  String imageUrl;
  int previousPrice;

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        title = json['title'],
        discount = json['discount'],
        imageUrl = json['image'],
        previousPrice = json['previous_price'] ?? json['price'];
}
