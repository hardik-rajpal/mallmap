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
          title: 'Amul Brown Bread',
          imgurl:
              'https://www.bigbasket.com/media/uploads/p/l/1203796_1-bb-combo-fresho-brown-bread-chemical-free-400gm-amul-pasteurised-butter-100gm.jpg',
          description: '500gms, brown bread.',
          cost: 'Rs. 40',
          uuid: 'uuid'),
      Product(
          title: 'Parachute Oil',
          imgurl: 'https://m.media-amazon.com/images/I/61dUCXFgN3L._SX679_.jpg',
          cost: 'Rs. 110',
          description: '500ml, hair oil',
          uuid: 'uuid'),
      Product(
          title: 'Kit Kat',
          imgurl:
              'https://www.jiomart.com/images/product/600x600/490001864/nestle-kit-kat-37-3-g-product-images-o490001864-p490001864-0-202203151147.jpg',
          description: '100gms, chocolate.',
          cost: 'Rs. 30',
          uuid: 'uuid'),
      Product(
          title: 'Nescafe Coffee',
          imgurl:
              'https://www.jiomart.com/images/product/original/490001207/nescafe-classic-instant-coffee-50-g-pouch-product-images-o490001207-p490001207-0-202203170715.jpg',
          description: '500gms, coffee.',
          cost: 'Rs. 80',
          uuid: 'uuid'),
      Product(
          title: 'Highlighter FC',
          imgurl:
              'https://m.media-amazon.com/images/I/71dsHluDBZL._SL1200_.jpg',
          description: 'highlighters, Faber Castle.',
          cost: 'Rs. 40',
          uuid: 'uuid'),
      Product(
          title: 'Lux Soap',
          imgurl:
              'https://m.media-amazon.com/images/I/61gsXq2Pb+L._SL1000_.jpg',
          description: '500gms, soap.',
          cost: 'Rs. 40',
          uuid: 'uuid'),
    ];
  }
}
