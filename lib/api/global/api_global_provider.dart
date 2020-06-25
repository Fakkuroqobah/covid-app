import 'package:covid/model/m_global.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiGlobalProvider {
  final _dio = Dio();
  final String _globalUrl = "https://covid19.mathdro.id/api";

  Future<GlobalModel> getGlobal() async {
    try {
      final response = await _dio.get(_globalUrl);
      
      return GlobalModel.fromJson(response.data);
    } catch(error) {
      debugPrint(error.toString());
      return GlobalModel.withError(error.toString());
    }
  }
}