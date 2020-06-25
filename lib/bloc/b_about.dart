import 'package:covid/api/about/api_about_repository.dart';
import 'package:covid/model/m_about.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class AboutState {}

class AboutInitial extends AboutState {}

class AboutLoading extends AboutState {}

class AboutFailure extends AboutState {
  final String errorMessage;

  AboutFailure(this.errorMessage);
}

class AboutLoaded extends AboutState {
  final AboutModel aboutModel;

  AboutLoaded(this.aboutModel);
}

class AboutEvent {}

class AboutBloc extends Bloc<AboutEvent, AboutState> {
  final ApiAboutRepository _apiAboutRepository = ApiAboutRepository();

  @override
  AboutState get initialState => AboutInitial();

  @override
  Stream<AboutState> mapEventToState(AboutEvent event) async* {
    yield AboutLoading();
    AboutModel aboutModel = await _apiAboutRepository.fetchAbout();

    if(aboutModel.error != null) {
      yield AboutFailure(aboutModel.error);
      return;
    }

    yield AboutLoaded(aboutModel);
  }
}