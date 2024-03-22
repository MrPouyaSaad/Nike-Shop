// ignore_for_file: public_member_api_docs, sort_constructors_first
class ProductModel {
  int id;
  int price;
  String title;
  int discount;
  String imgUrl;
  int prePrice;
  ProductModel({
    required this.id,
    required this.price,
    required this.title,
    required this.discount,
    required this.imgUrl,
    required this.prePrice,
  });
  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        price = json['price'],
        title = json['title'],
        discount = json['discount'],
        imgUrl = json['image'],
        prePrice = json['previous_price'];
}
