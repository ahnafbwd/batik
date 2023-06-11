class Product {
  final int id;
  final String name;
  final String price;
  final String image;

  Product(
    this.id,
    this.name,
    this.price,
    this.image,
  );

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] ?? 0,
        name = json['name'] ?? '',
        price = json['price'] ?? '',
        image = json['image'] ?? '';
}
