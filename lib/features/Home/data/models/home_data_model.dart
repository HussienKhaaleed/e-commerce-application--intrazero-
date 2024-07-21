class HomeProductsModel {
  int? productId;
  int? quantity;
  String? name;
  String? description;
  double? price;
  String? unit;
  String? image;
  int? discount;
  bool? availability;
  String? brand;
  String? category;
  double? rating;

  HomeProductsModel({
    this.productId,
    this.name,
    this.description,
    this.price,
    this.unit,
    this.image,
    this.discount,
    this.availability,
    this.brand,
    this.category,
    this.rating,
    this.quantity,
  });
  factory HomeProductsModel.fromJson(Map<String, dynamic> json) =>
      HomeProductsModel(
        productId: json["product_id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        unit: json["unit"],
        image: json["image"],
        discount: json["discount"],
        availability: json["availability"],
        brand: json["brand"],
        category: json["category"],
        rating: json["rating"],
      );
}
