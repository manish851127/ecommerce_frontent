import 'package:ecommerce_frontend/data/models/cart/cart_item_model.dart';

class Calculation{
  static int cartTotal(List<CartItemModel> items){
    int total=0;
    for(int i=0; i<items.length; i++){
      total += items[i].product!.price! * items[i].quantity!;
    }
      return total;
    
  }
}