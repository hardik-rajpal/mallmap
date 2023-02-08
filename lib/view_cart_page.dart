import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mallmap/comps/uifuncs.dart';
import 'package:mallmap/cubits/cart_cubit.dart';
import 'package:mallmap/data_service.dart';
import 'package:mallmap/models.dart';

class ViewCartPage extends StatefulWidget {
  final CartCubit cartCubit;
  const ViewCartPage(this.cartCubit, {Key? key}) : super(key: key);

  @override
  State<ViewCartPage> createState() => _ViewCartPageState();
}

class _ViewCartPageState extends State<ViewCartPage> {
  List<Product>? _productData;
  final DataService dataService = DataService();
  @override
  void initState() {
    super.initState();
    widget.cartCubit.stream.listen((state) {
      updateCartView(state);
    });
    updateCartView(widget.cartCubit.state);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: (_productData != null)
          ? (_productData!.isNotEmpty
              ? Column(
                  children: _productData!
                      .map((product) =>
                          makeProductCard(product, context, widget))
                      .toList())
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Icon(
                        Icons.shopping_cart_outlined,
                        size: 100,
                      ),
                      Text(
                        'Cart Empty',
                        style: TextStyle(fontSize: 20),
                      ),
                      Text('Add items by scanning their QR code')
                    ],
                  ),
                ))
          : const Center(child: CircularProgressIndicator()),
    );
  }

  void updateCartView(CartState state) {
    Future.wait(state.products.map((uuid) {
      return dataService.getProductInfo(uuid, state.shopUuid);
    }).toList())
        .then(
      (value) {
        List<Product> uniqprods = [];
        for (int i = 0; i < value.length; i++) {
          if (uniqprods.map((e) => e.uuid).contains(value[i].uuid)) {
            uniqprods[uniqprods
                    .map((e) => e.uuid)
                    .toList()
                    .indexOf(value[i].uuid)]
                .qty++;
          } else {
            uniqprods.add(value[i]);
          }
          log(uniqprods.toString());
        }
        setState(() {
          // _productData = uniqprods;
          _productData = [
            Product(
                title: 'Amul Brown Bread',
                imgurl:
                    'https://www.bigbasket.com/media/uploads/p/l/1203796_1-bb-combo-fresho-brown-bread-chemical-free-400gm-amul-pasteurised-butter-100gm.jpg',
                description: '500gms, brown bread.',
                cost: 'Rs. 40',
                uuid: 'uuid'),
            Product(
                title: 'Parachute Oil',
                imgurl:
                    'https://m.media-amazon.com/images/I/61dUCXFgN3L._SX679_.jpg',
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
          ];
          _productData![0].qty = 2;
          _productData![1].qty = 3;
          _productData![2].qty = 1;
        });
      },
    );
  }
}
