import 'package:covid/model/m_about.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiAboutProvider {
  final _dio = Dio();
  final String _aboutUrl = "https://api.github.com/users/Fakkuroqobah";

  Future<AboutModel> getAbout() async {
    try {
      final response = await _dio.get(_aboutUrl);
      
      return AboutModel.fromJson(response.data);
    } catch(error) {
      debugPrint(error.toString());
      return AboutModel.withError(error.toString());
    }
  }
}