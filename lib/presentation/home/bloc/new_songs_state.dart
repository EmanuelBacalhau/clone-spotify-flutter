import 'package:clone_spotify/data/models/song/song.dart';

abstract class NewSongsState {}

class NewsSongLoading extends NewSongsState {}

class NewSongsLoaded extends NewSongsState {
  final List<Song> songs;

  NewSongsLoaded(this.songs);
}

class NewSongLoadFailure extends NewSongsState {
  final String message;

  NewSongLoadFailure(this.message);
}
