import 'package:clone_spotify/data/models/song/song.dart';

abstract class PlaylistState {}

class PlaylistLoading extends PlaylistState {}

class PlaylistLoaded extends PlaylistState {
  final List<Song> songs;

  PlaylistLoaded(this.songs);
}

class PlaylistLoadFailure extends PlaylistState {
  final String message;

  PlaylistLoadFailure(this.message);
}
