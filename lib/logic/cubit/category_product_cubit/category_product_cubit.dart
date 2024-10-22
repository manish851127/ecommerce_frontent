import 'package:ecommerce_frontend/data/models/Category/category_model.dart';
import 'package:ecommerce_frontend/data/respository/product_repository.dart';
import 'package:ecommerce_frontend/logic/cubit/category_product_cubit/category_product_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryProductCubit extends Cubit<CategoryProductState>{
   final CategoryModel category;
   CategoryProductCubit(this.category): super(CategoryProductInitialState()){
    _initalized();
   }
   final _productRepository=ProductRepository();

   void _initalized()async{
    try {
      emit(CategoryProductLoadingState(state.products));
       final products= await  _productRepository.fetchProductsByCategoryId(category.sId!);
       emit(CategoryProductLoaddedState(products));

    }catch(e){
      emit(CategoryProductErrorState(state.products, e.toString()));
    }
   }
}