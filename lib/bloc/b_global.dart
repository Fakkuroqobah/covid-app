import 'package:covid/api/global/api_global_repository.dart';
import 'package:covid/model/m_global.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class GlobalState {}

class GlobalInitial extends GlobalState {}

class GlobalLoading extends GlobalState {}

class GlobalFailure extends GlobalState {
  final String errorMessage;

  GlobalFailure(this.errorMessage);
}

class GlobalLoaded extends GlobalState {
  final GlobalModel globalModel;

  GlobalLoaded(this.globalModel);
}

class GlobalEvent {}

class GlobalBloc extends Bloc<GlobalEvent, GlobalState> {
  final ApiGlobalRepository _apiGlobalRepository = ApiGlobalRepository();

  @override
  GlobalState get initialState => GlobalInitial();

  @override
  Stream<GlobalState> mapEventToState(GlobalEvent event) async* {
    yield GlobalLoading();
    GlobalModel globalModel = await _apiGlobalRepository.fetchGlobal();

    if(globalModel.error != null) {
      yield GlobalFailure(globalModel.error);
      return;
    }

    yield GlobalLoaded(globalModel);
  }
}