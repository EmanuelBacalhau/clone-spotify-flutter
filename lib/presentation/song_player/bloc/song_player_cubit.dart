import 'package:clone_spotify/presentation/song_player/bloc/song_player_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';

class SongPlayerCubit extends Cubit<SongPlayerState> {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration songDuration = Duration.zero;
  Duration songPosition = Duration.zero;

  SongPlayerCubit() : super(SongPlayerLoading()) {
    audioPlayer.positionStream.listen((position) {
      songPosition = position;
      emit(SongPlayerLoaded());
    });

    audioPlayer.durationStream.listen((duration) {
      songDuration = duration!;
      emit(SongPlayerLoaded());
    });
  }

  Future<void> loadSong(String url) async {
    try {
      await audioPlayer.setUrl(url);

      emit(SongPlayerLoaded());
    } catch (e) {
      emit(SongPlayerFailure());
    }
  }

  Future<void> playOrPauseSong() async {
    if (audioPlayer.playing) {
      await audioPlayer.pause();
    } else {
      await audioPlayer.play();
    }

    emit(SongPlayerLoaded());
  }

  @override
  Future<void> close() async {
    await audioPlayer.dispose();

    return super.close();
  }
}
