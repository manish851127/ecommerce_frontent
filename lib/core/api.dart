import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const BASE_URL= "http://192.168.31.75:5000/api";

const Map<String,dynamic> DEFAULT_HEADER ={
  "content-type": "application/json"
};

class Api{
  final Dio _dio= Dio();
   Dio get sendRequest=> _dio;

  Api(){
    _dio.options.baseUrl=BASE_URL;
    _dio.options.headers=DEFAULT_HEADER;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true
    ));
  }
}

class ApiResponse{
  bool success;
  dynamic data;
  String? message;

  ApiResponse({
    required this.success,
    this.data,
    this.message
  });

  factory ApiResponse.fromResponse(Response response){
    final data= response.data as Map<String, dynamic>;
    return ApiResponse(
      success: data['success'],
      data: data['data'],
      message: data['message'] ?? "Unexpected error",
    );
  }
}