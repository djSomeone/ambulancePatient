import 'package:dio/dio.dart';

class ResponseStructure{
  static Map<String,dynamic> toResponseStructure(Response r)
  {
    return {
      "statusCode":r.statusCode,
      "body":r.data["body"],
    };
  }
}