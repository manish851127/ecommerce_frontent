import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/core/api.dart';
import 'package:ecommerce_frontend/data/models/Category/category_model.dart';

class CategoryRepository{
  final Api _api= Api();

// create account
  Future<List<CategoryModel>> fetchCategories() async{
    try{
        Response response= await _api.sendRequest.get("/category");
      ApiResponse apiResponse=ApiResponse.fromResponse(response);

      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }
      
     return (apiResponse.data as List<dynamic>).map((json)=> CategoryModel.fromJson(json)).toList();
      
    }
    catch(e){
       rethrow;
    }
  }

}