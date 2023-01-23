import 'package:bloc/bloc.dart';

class CartState {
  List products;
  late String shopUuid;
  CartState(this.shopUuid, this.products);
}

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartState('', []));
  void addProduct(dynamic product) {
    emit(CartState(state.shopUuid, [...state.products, product]));
  }

  void setShopUuid(String shopUuid) {
    emit(CartState(shopUuid, state.products));
  }
}
