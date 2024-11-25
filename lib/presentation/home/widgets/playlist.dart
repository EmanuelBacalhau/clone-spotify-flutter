import 'package:clone_spotify/common/helper/is_dark_mode.dart';
import 'package:clone_spotify/core/configs/assets/app_vectors.dart';
import 'package:clone_spotify/core/configs/theme/app_colors.dart';
import 'package:clone_spotify/data/models/song/song.dart';
import 'package:clone_spotify/presentation/home/bloc/playlist_cubit.dart';
import 'package:clone_spotify/presentation/home/bloc/playlist_state.dart';
import 'package:clone_spotify/presentation/song_player/pages/song_player.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Playlist extends StatelessWidget {
  const Playlist({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PlaylistCubit()..getPlaylist(),
      child: BlocBuilder<PlaylistCubit, PlaylistState>(
        builder: (context, state) {
          if (state is PlaylistLoading) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
          if (state is PlaylistLoaded) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'Playlist',
                      style: TextStyle(
                        color: context.isDarkMode
                            ? Colors.white
                            : AppColors.darkGrey,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text(
                      'ver mais',
                      style: TextStyle(
                        color: AppColors.grey,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _songs(state.songs), // Renderiza a lista de músicas
              ],
            );
          }

          return Container();
        },
      ),
    );
  }

  Widget _songs(List<Song> playlist) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) => Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SongPlayer(
                    song: playlist[index],
                  ),
                ),
              );
            },
            child: Container(
              width: 46,
              height: 46,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.darkGrey,
              ),
              child: const Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                playlist[index].title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                playlist[index].artist,
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            playlist[index].duration.toString(),
            style: const TextStyle(
              color: AppColors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(width: 30),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite,
              color: AppColors.darkGrey,
            ),
          )
        ],
      ),
      separatorBuilder: (context, index) => const SizedBox(
        height: 10,
      ),
      itemCount: playlist.length,
    );
  }
}
