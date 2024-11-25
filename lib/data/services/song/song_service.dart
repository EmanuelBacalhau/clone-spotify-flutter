import 'package:clone_spotify/data/models/song/song.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';

abstract class SongService {
  Future<Either> getSongList();
  Future<Either> getPlaylist();
}

class SongServiceImpl implements SongService {
  @override
  Future<Either> getSongList() async {
    try {
      List<Song> songs = [];

      var result = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .limit(3)
          .get();

      for (var element in result.docs) {
        var songModel = Song.fromJson(element.data());
        songs.add(songModel);
      }

      return Right(songs);
    } catch (e) {
      return const Left('Erro ao buscar músicas');
    }
  }

  Future<Either> getPlaylist() async {
    try {
      List<Song> songs = [];
      print('Iniciando consulta ao Firestore para getPlaylist...');

      var result = await FirebaseFirestore.instance
          .collection('songs')
          .orderBy('releaseDate', descending: true)
          .get();

      print('Documentos retornados: ${result.docs.length}');

      for (var element in result.docs) {
        var songModel = Song.fromJson(element.data());
        print('Processando documento: ${songModel}');
        songs.add(songModel);
      }

      print('Playlist carregada com ${songs.length} músicas');
      return Right(songs);
    } catch (e) {
      print('Erro ao buscar playlist: $e');
      return Left('Erro ao buscar músicas: $e');
    }
  }
}
