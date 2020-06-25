import 'package:covid/api/indonesia/api_indonesia_repository.dart';
import 'package:covid/model/m_indonesia.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class IndonesiaState {}

class IndonesiaInitial extends IndonesiaState {}

class IndonesiaLoading extends IndonesiaState {}

class IndonesiaFailure extends IndonesiaState {
  final String errorMessage;

  IndonesiaFailure(this.errorMessage);
}

class IndonesiaLoaded extends IndonesiaState {
  final IndonesiaModel indonesiaModel;

  IndonesiaLoaded(this.indonesiaModel);
}

class IndonesiaEvent {}

class IndonesiaBloc extends Bloc<IndonesiaEvent, IndonesiaState> {
  final ApiIndonesiaRepository _apiIndonesiaRepository = ApiIndonesiaRepository();

  @override
  IndonesiaState get initialState => IndonesiaInitial();

  @override
  Stream<IndonesiaState> mapEventToState(IndonesiaEvent event) async* {
    yield IndonesiaLoading();
    IndonesiaModel indonesiaModel = await _apiIndonesiaRepository.fetchIndonesia();

    if(indonesiaModel.error != null) {
      yield IndonesiaFailure(indonesiaModel.error);
      return;
    }

    yield IndonesiaLoaded(indonesiaModel);
  }
}