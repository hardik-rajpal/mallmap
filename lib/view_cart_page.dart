import 'package:flutter/material.dart';
import 'package:mallmap/cubits/cart_cubit.dart';

class ViewCartPage extends StatefulWidget {
  final CartCubit cartCubit;
  const ViewCartPage(this.cartCubit, {Key? key}) : super(key: key);

  @override
  State<ViewCartPage> createState() => _ViewCartPageState();
}

class _ViewCartPageState extends State<ViewCartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Column(
          children: widget.cartCubit.state.products
              .map((e) => Text(e.toString()))
              .toList()),
    );
  }
}
