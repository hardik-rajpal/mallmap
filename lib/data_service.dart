import 'package:mallmap/models.dart';

class DataService {
  final String baseUrl = 'http:localhost:8080/';
  final String getProducts = '';
  final String getMallMap = '';
  final String getShopMap = '';
  Future<List<dynamic>> getCatalogue(dynamic shopdata) async {
    List products = [];
    return products;
  }

  Future<Product> getProductInfo(String productUuid, String shopUuid) async {
    return Product(
        title: 'Product 1',
        imgurl: 'https://i.imgur.com/vxP6SFl.png',
        description: 'This is an amazing product',
        uuid: productUuid,
        cost: '\$99');
  }
}
