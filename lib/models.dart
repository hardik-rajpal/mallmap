class Product {
  final String title;
  final String imgurl;
  final String description;
  final String uuid;
  final String cost;
  int qty = 1;
  Product(
      {required this.title,
      required this.imgurl,
      required this.description,
      required this.cost,
      required this.uuid});
  @override
  int get hashCode => uuid.hashCode;
}
