part of 'music_page_bloc.dart';

sealed class MusicPageState {}

final class MusicPageInitial extends MusicPageState {}

final class MusicPageLoading extends MusicPageState {}

final class AddPlayListSuccess extends MusicPageState {
  final List<Song> songs;

  AddPlayListSuccess({required this.songs});
}

final class MusicPageChangeIndexSuccess extends MusicPageState {
  final SongDetail songDetail;

  MusicPageChangeIndexSuccess({required this.songDetail});
}
