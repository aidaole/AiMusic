import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_page_event.dart';
part 'home_page_state.dart';

class HomePageBloc extends Bloc<HomePageEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial()) {
    on<HomeSwitchTabEvent>(_onHomeSwitchTab);
  }

  void _onHomeSwitchTab(HomeSwitchTabEvent event, Emitter<HomePageState> emit) {
    int index = event.index;
    emit(HomePageSwitchTabState(index));
  }
}
