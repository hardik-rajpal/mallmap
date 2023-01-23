import 'dart:developer';

import 'package:flutter/material.dart';
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
    Future.wait(widget.cartCubit.state.products.map((uuid) {
      return dataService.getProductInfo(uuid, widget.cartCubit.state.shopUuid);
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
        log('here');
        setState(() {
          _productData = uniqprods;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: (_productData != null)
          ? Column(
              children: _productData!
                  .map((product) => Card(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Image.network(
                                product.imgurl,
                                width: 100,
                                height: 100,
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.title,
                                    style: const TextStyle(fontSize: 20),
                                  ),
                                  Text(product.description)
                                ],
                              ),
                              Text(product.cost),
                              Column(children: [
                                IconButton(
                                    onPressed: () {
                                      //confirm delete...
                                      //remove from widget.cartCubit
                                    },
                                    icon: const Icon(Icons.delete)),
                                Text(product.qty.toString())
                              ])
                            ]),
                      ))
                  .toList())
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
