part of 'music_page_bloc.dart';

sealed class MusicPageEvent {}

class MusicPageInitEvent extends MusicPageEvent {}

class AddPlayListEvent extends MusicPageEvent {
  final List<Song> tracks;

  AddPlayListEvent({required this.tracks});
}

class MusicPageChangeIndexEvent extends MusicPageEvent {
  final int index;

  MusicPageChangeIndexEvent({required this.index});
}
