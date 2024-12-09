part of 'home_page_bloc.dart';

sealed class HomePageEvent {}

class HomeSwitchTabEvent extends HomePageEvent {
  final int index;
  HomeSwitchTabEvent(this.index);
}
