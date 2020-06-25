import 'package:covid/api/about/api_about_provider.dart';
import 'package:covid/model/m_about.dart';

class ApiAboutRepository {
  final ApiAboutProvider _apiAboutProvider = ApiAboutProvider();

  Future<AboutModel> fetchAbout() => _apiAboutProvider.getAbout();
}