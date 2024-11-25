import 'package:clone_spotify/data/services/song/song_service.dart';
import 'package:clone_spotify/presentation/home/bloc/playlist_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PlaylistCubit extends Cubit<PlaylistState> {
  PlaylistCubit() : super(PlaylistLoading());

  SongService songService = SongServiceImpl();

  Future<void> getPlaylist() async {
    var songs = await songService.getPlaylist();
    songs.fold((l) {
      emit(PlaylistLoadFailure(l));
    }, (data) {
      emit(PlaylistLoaded(data));
    });
  }
}
