import 'package:covid/api/indonesia/api_indonesia_repository.dart';
import 'package:covid/model/m_provinsi.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ProvinsiState {}

class ProvinsiInitial extends ProvinsiState {}

class ProvinsiLoading extends ProvinsiState {}

class ProvinsiFailure extends ProvinsiState {
  final String errorMessage;

  ProvinsiFailure(this.errorMessage);
}

class ProvinsiLoaded extends ProvinsiState {
  final List<ProvinsiModel> provinsiModel;

  ProvinsiLoaded(this.provinsiModel);
}

class ProvinsiEvent {}

class ProvinsiBloc extends Bloc<ProvinsiEvent, ProvinsiState> {
  final ApiIndonesiaRepository _apiProvinsiRepository = ApiIndonesiaRepository();

  @override
  ProvinsiState get initialState => ProvinsiInitial();

  @override
  Stream<ProvinsiState> mapEventToState(ProvinsiEvent event) async* {
    yield ProvinsiLoading();
    List<ProvinsiModel> provinsiModel = await _apiProvinsiRepository.fetchProvinsi();

    if(provinsiModel == null) {
      yield ProvinsiFailure("error");
      return;
    }

    yield ProvinsiLoaded(provinsiModel);
  }
}