import 'package:bloc/bloc.dart';

enum Condition {
  active, inactive
}

abstract class PageSlideState {}

class PageSlideInitial extends PageSlideState {}

class PageSlideSuccess extends PageSlideState {
  final bool type;

  PageSlideSuccess(this.type);
}

class PageSlideFailed extends PageSlideState {
  final String error;

  PageSlideFailed(this.error);
}

class PageSlideEvent {
  final Condition condition;

  PageSlideEvent(this.condition);
}

class PageSlideBloc extends Bloc<PageSlideEvent, PageSlideState> {
  @override
  PageSlideState get initialState {
    return PageSlideInitial();
  }

  @override
  Stream<PageSlideState> mapEventToState(PageSlideEvent event) async* {
    switch(event.condition) {
      case Condition.active:
        yield PageSlideSuccess(true);
        break;
      case Condition.inactive:
        yield PageSlideSuccess(false);
        break;
      default:
        yield PageSlideFailed('Unknown condition');
    }
  }
}