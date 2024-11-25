import 'package:clone_spotify/data/services/song/song_service.dart';
import 'package:clone_spotify/presentation/home/bloc/new_songs_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewsSongsCubit extends Cubit<NewSongsState> {
  NewsSongsCubit() : super(NewsSongLoading());

  SongService songService = SongServiceImpl();

  Future<void> getNewSongs() async {
    var songs = await songService.getSongList();
    songs.fold((l) {
      emit(NewSongLoadFailure(l));
    }, (data) {
      emit(NewSongsLoaded(data));
    });
  }
}
