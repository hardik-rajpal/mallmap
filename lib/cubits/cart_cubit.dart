import 'dart:developer';

import 'package:bloc/bloc.dart';

class CartState {
  List products;
  CartState(this.products);
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState([]));
  void addProduct(dynamic product) {
    log('product added to cart');
    emit(CartState([...state.products, product]));
  }
}
