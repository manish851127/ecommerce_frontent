import 'package:ecommerce_frontend/data/models/Category/category_model.dart';
import 'package:ecommerce_frontend/data/respository/category_repository.dart';
import 'package:ecommerce_frontend/logic/cubit/category_cubit/category_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoryCubit extends Cubit<CategoryState>{
  CategoryCubit(): super(CategoryInitialState()){
    _initialize();
  }
  final _categoryRepository=CategoryRepository();
  void _initialize() async{
    emit(CategoryLoadedState(state.categories));
    try{
     List<CategoryModel> categories= await _categoryRepository.fetchCategories();
     emit(CategoryLoadedState(categories));
    }catch(e){
      emit(CategoryErrorState(state.categories, e.toString()));
    }
  }
}