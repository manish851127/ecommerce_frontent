import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ecommerce_frontend/core/api.dart';
import 'package:ecommerce_frontend/data/models/user/user_model.dart';

class UserRepository{
  final Api _api= Api();

// create account
  Future<UserModel> createUser({
    required String email,
    required String password
  }) async{
    try{
        Response response= await _api.sendRequest.post(
        "/user/createAccount",
       data: jsonEncode({
        "email": email,
        "password": password
       })
      );
      ApiResponse apiResponse=ApiResponse.fromResponse(response);

      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }
      // convert raw data to model

      return UserModel.fromJson(apiResponse.data);
    }
    catch(e){
       rethrow;
    }
  }

  // SignIn Account
  Future<UserModel> signIn({
    required String email,
    required String password
  }) async{
    try{
        Response response= await _api.sendRequest.post(
        "/user/signIn",
       data: jsonEncode({
        "email": email,
        "password": password
       })
      );
      ApiResponse apiResponse=ApiResponse.fromResponse(response);

      if(!apiResponse.success){
        throw apiResponse.message.toString();
      }
      // convert raw data to model

      return UserModel.fromJson(apiResponse.data);
    }
    catch(e){
       rethrow;
    }
  }

}