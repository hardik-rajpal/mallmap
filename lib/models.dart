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
  static List<Product> getDummies() {
    return [
      Product(
          title: 'Product 2',
          imgurl: 'https://i.imgur.com/vxP6SFl.png',
          description: 'Another great product',
          cost: '\$89',
          uuid: 'uuid'),
      Product(
          title: 'Product 3',
          imgurl: 'https://i.imgur.com/vxP6SFl.png',
          cost: '\$79',
          description: 'Do I even need to talk?',
          uuid: 'uuid')
    ];
  }
}
