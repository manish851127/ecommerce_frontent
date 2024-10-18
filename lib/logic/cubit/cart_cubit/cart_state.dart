import 'package:ecommerce_frontend/data/models/cart/cart_item_model.dart';

abstract class CartState{
  final List<CartItemModel> items;
  CartState(this.items);
}

class CartInitialState extends CartState{
  CartInitialState(): super([]);
}

class CartLoadingState extends CartState{
  CartLoadingState(super.items);
}

class CartLoaddedState extends CartState{
  CartLoaddedState(super.items);
}

class CartErrorState extends CartState{
  final String message;
  CartErrorState(super.items, this.message);
}