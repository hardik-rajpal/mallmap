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
          _productData = uniqprods;
        });
      },
    );
  }
}
