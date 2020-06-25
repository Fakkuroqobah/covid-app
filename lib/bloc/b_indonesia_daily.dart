import 'package:covid/api/indonesia/api_indonesia_repository.dart';
import 'package:covid/model/m_daily_indonesia.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DailyIndonesiaState {}

class DailyIndonesiaInitial extends DailyIndonesiaState {}

class DailyIndonesiaLoading extends DailyIndonesiaState {}

class DailyIndonesiaFailure extends DailyIndonesiaState {
  final String errorMessage;

  DailyIndonesiaFailure(this.errorMessage);
}

class DailyIndonesiaLoaded extends DailyIndonesiaState {
  final List<DailyIndonesiaModel> dailyindonesiaModel;

  DailyIndonesiaLoaded(this.dailyindonesiaModel);
}

class DailyIndonesiaEvent {}

class DailyIndonesiaBloc extends Bloc<DailyIndonesiaEvent, DailyIndonesiaState> {
  final ApiIndonesiaRepository _apiDailyIndonesiaRepository = ApiIndonesiaRepository();

  @override
  DailyIndonesiaState get initialState => DailyIndonesiaInitial();

  @override
  Stream<DailyIndonesiaState> mapEventToState(DailyIndonesiaEvent event) async* {
    yield DailyIndonesiaLoading();
    List<DailyIndonesiaModel> dailyindonesiaModel = await _apiDailyIndonesiaRepository.fetchDailyIndonesia();

    if(dailyindonesiaModel == null) {
      yield DailyIndonesiaFailure("error");
      return;
    }

    yield DailyIndonesiaLoaded(dailyindonesiaModel);
  }
}