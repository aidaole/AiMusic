part of 'music_page_bloc.dart';

sealed class MusicPageEvent {}

class MusicPageInitEvent extends MusicPageEvent {}

class AddPlayListEvent extends MusicPageEvent {
  final List<Track> tracks;

  AddPlayListEvent({required this.tracks});
}
