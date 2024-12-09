part of 'music_page_bloc.dart';

sealed class MusicPageState {}

final class MusicPageInitial extends MusicPageState {}

final class AddPlayListSuccess extends MusicPageState {
  final List<Track> tracks;

  AddPlayListSuccess({required this.tracks});
}
