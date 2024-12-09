part of 'home_page_bloc.dart';

sealed class HomePageState {}

final class HomePageInitial extends HomePageState {}

final class HomePageSwitchTabState extends HomePageState {
  final int index;
  HomePageSwitchTabState(this.index);
}
