
import 'package:ecommerce_frontend/data/models/product/product_model.dart';
import 'package:ecommerce_frontend/data/respository/product_repository.dart';
import 'package:ecommerce_frontend/logic/cubit/product_cubit/product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductCubit extends Cubit<ProductState>{
  ProductCubit(): super(ProductInitialState()){
    _initialize();
  }
  final _productRepository=ProductRepository();
  void _initialize() async{
    emit(ProductLoadedState(state.products));
    try{
     List<ProductModel> products= await _productRepository.fetchAllProducts();
     emit(ProductLoadedState(products));
    }catch(e){
      emit(ProductErrorState(state.products, e.toString()));
    }
  }
}