import 'package:covid/model/m_daily_indonesia.dart';
import 'package:covid/model/m_indonesia.dart';
import 'package:covid/model/m_provinsi.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class ApiIndonesiaProvider {
  final _dio = Dio();
  final String _indonesiaUrl = "https://covid19.mathdro.id/api/countries/Indonesia";
  final String _dailyIndonesiaUrl = "https://api.covid19api.com";
  final String _provinsiUrl = "https://indonesia-covid-19.mathdro.id/api/provinsi";

  Future<IndonesiaModel> getIndonesia() async {
    try {
      final response = await _dio.get(_indonesiaUrl);
      
      return IndonesiaModel.fromJson(response.data);
    } catch(error) {
      debugPrint(error.toString());
      return IndonesiaModel.withError(error.toString());
    }
  }

  Future<List<DailyIndonesiaModel>> getDailyIndonesia() async {
    try {
      final response = await _dio.get(
        "$_dailyIndonesiaUrl/country/indonesia?from=2020-06-${DateTime.now().day - 8}T00:00:00Z&to=2020-06-${DateTime.now().day}T00:00:00Z"
      );
      List<DailyIndonesiaModel> data = [];

      for(int i = 0; i < response.data.length; i++) {
        data.add(DailyIndonesiaModel.fromJson(response.data[i]));
      }

      return data;
    } catch(error) {
      debugPrint(error.toString());
      throw new Exception("Data indonesia not found");
      // return DailyIndonesiaModel.withError(error.toString());
    }
  }

  Future<List<ProvinsiModel>> getProvinsi() async {
    try {
      final response = await _dio.get(_provinsiUrl);
      List<ProvinsiModel> data = [];

      for(int i = 0; i < response.data['data'].length; i++) {
        data.add(ProvinsiModel.fromJson(response.data['data'][i]));
      }

      return data;
    }catch(error) {
      debugPrint(error.toString());
      throw new Exception("Data provinsi not found");
    }
  }
}