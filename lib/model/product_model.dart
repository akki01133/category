class ProductModel
{
  final String id;
  final String imageURL;
  final String title;
  final String brand;
  final String price;
  final String saving;
  final String ratingCount;
  final String ratingValue;

  ProductModel({
    required this.id,
    required this.imageURL,
    required this.title,
    required this.saving,
    required this.price,
    required this.brand,
    required this.ratingValue,
    required this.ratingCount
  });
 factory ProductModel.fromJson(Map<String,dynamic> json)
 {
   return ProductModel(id: json["id"],
       imageURL:json['imageUrl'],
       title: json['title'],
       saving: json['savings'],
       price: json['price'],
       brand: json['brand'],
       ratingValue: json['ratingValue'],
       ratingCount: json['ratingCount']);
 }
}