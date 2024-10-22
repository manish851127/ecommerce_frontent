import 'dart:async';
import 'package:ecommerce_frontend/data/models/cart/cart_item_model.dart';
import 'package:ecommerce_frontend/data/models/product/product_model.dart';
import 'package:ecommerce_frontend/data/respository/cart_repository.dart';
import 'package:ecommerce_frontend/logic/cubit/cart_cubit/cart_state.dart';
import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_cubit.dart';
import 'package:ecommerce_frontend/logic/cubit/user_cubit/user_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class CartCubit extends Cubit<CartState>{
  final UserCubit _userCubit;
  StreamSubscription? _userSubscription;
  CartCubit(this._userCubit) : super(CartInitialState()){
    _handleUserState(_userCubit.state);
     // listening to user cubit (for future updates)
   _userSubscription= _userCubit.stream.listen(_handleUserState);
  }

   void _handleUserState(UserState userState){
     if(userState is UserLoggedInState){
    _initalized(userState.userModel.sId!);

      }
      else if(state is UserLoggedOutState){
        emit(CartInitialState());
      }
   }
   final _cartRepository =CartRepository();

  void sortAndLoad(List<CartItemModel> items){
    items.sort((a, b) => b.product!.title!.compareTo(a.product!.title!),);
      emit(CartLoaddedState(items));
    }
   
  void _initalized(String userId) async{
    emit(CartLoadingState(state.items));
    try{
      final items= await _cartRepository.fetchCartForUser(userId);
      sortAndLoad(items);
      }
    catch(e){
      emit(CartErrorState(state.items, e.toString()));
    }
  }
  
  void addToCart(ProductModel product, int quantity) async{
    try{

       if(_userCubit.state is UserLoggedInState){
        UserLoggedInState userState= _userCubit.state as UserLoggedInState;

        CartItemModel cartItemModel=CartItemModel(
        product: product,
        quantity: quantity
      );
       final items= await _cartRepository.addToCart(cartItemModel, userState.userModel.sId!);
      sortAndLoad(items);
       }
       else{
        throw "An error occured while adding the items";
       }
      
    }
    catch(e) {
      emit(CartErrorState(state.items, e.toString()));
    }
  }

  void removeFromCart(ProductModel product) async{
    try{

       if(_userCubit.state is UserLoggedInState){
        UserLoggedInState userState= _userCubit.state as UserLoggedInState;

       final items= await _cartRepository.deleteToCart(product.sId!, userState.userModel.sId!);
      sortAndLoad(items);
       }
       else{
        throw "An error occured while removing the items";
       }
      
    }
    catch(e) {
      emit(CartErrorState(state.items, e.toString()));
    }
  }

  bool cartContains(ProductModel product){
    if(state.items.isNotEmpty){
     final foundItem= state.items.where((item)=> item.product!.sId==product.sId!).toList();
     if(foundItem.isNotEmpty){
      return true;
     }
     else{
      return false;
     }
    }else {
      return false;
    }

  }

  @override
  Future<void> close() {
    _userSubscription?.cancel();
    return super.close();
  }
}

