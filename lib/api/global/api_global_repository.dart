import 'package:covid/api/global/api_global_provider.dart';
import 'package:covid/model/m_global.dart';

class ApiGlobalRepository {
  final ApiGlobalProvider _apiGlobalProvider = ApiGlobalProvider();

  Future<GlobalModel> fetchGlobal() => _apiGlobalProvider.getGlobal();
}