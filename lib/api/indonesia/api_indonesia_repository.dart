import 'package:covid/api/indonesia/api_indonesia_provider.dart';
import 'package:covid/model/m_daily_indonesia.dart';
import 'package:covid/model/m_indonesia.dart';
import 'package:covid/model/m_provinsi.dart';

class ApiIndonesiaRepository {
  final ApiIndonesiaProvider _apiIndonesiaProvider = ApiIndonesiaProvider();

  Future<IndonesiaModel> fetchIndonesia() => _apiIndonesiaProvider.getIndonesia();
  Future<List<DailyIndonesiaModel>> fetchDailyIndonesia() => _apiIndonesiaProvider.getDailyIndonesia();
  Future<List<ProvinsiModel>> fetchProvinsi() => _apiIndonesiaProvider.getProvinsi();
}