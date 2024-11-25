import 'package:cloud_firestore/cloud_firestore.dart';

class Song {
  late String title;
  late String artist;
  late Timestamp releaseDate;
  late num duration;

  Song({
    required this.title,
    required this.artist,
    required this.releaseDate,
    required this.duration,
  });

  Song.fromJson(Map<String, dynamic> data) {
    title = data['title'];
    artist = data['artist'];
    releaseDate = data['releaseDate'];
    duration = data['duration'];
  }
}
