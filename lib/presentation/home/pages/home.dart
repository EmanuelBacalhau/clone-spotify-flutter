import 'package:clone_spotify/common/helper/is_dark_mode.dart';
import 'package:clone_spotify/common/widgets/appbar/app_bar.dart';
import 'package:clone_spotify/core/configs/assets/app_images.dart';
import 'package:clone_spotify/core/configs/assets/app_vectors.dart';
import 'package:clone_spotify/core/configs/theme/app_colors.dart';
import 'package:clone_spotify/presentation/auth/pages/sign_in.dart';
import 'package:clone_spotify/presentation/home/widgets/news_songs.dart';
import 'package:clone_spotify/presentation/home/widgets/playlist.dart';
import 'package:clone_spotify/presentation/intro/pages/get_started.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  final User? user = FirebaseAuth.instance.currentUser;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<String> tabs = [
    'Novidades',
    'Vídeo',
    'Artists',
    'Podcasts',
    'Gêneros',
    'Descobrir'
  ];

  late TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BasicAppBar(
        hideBack: true,
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 30,
          width: 30,
        ),
        actions: IconButton(
          onPressed: () {
            FirebaseAuth.instance.signOut();
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const GetStarted()),
              (route) => false,
            );
          },
          icon: const Icon(Icons.exit_to_app),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _homeArtistCard(),
              const SizedBox(height: 10),
              _tabs(context),
              const SizedBox(height: 10),
              SizedBox(
                height: 200,
                child: TabBarView(
                  controller: tabController,
                  children: [
                    const NewsSongs(),
                    Container(), // Vídeo
                    Container(), // Artists
                    Container(), // Podcasts
                    Container(), // Gêneros
                    Container(), // Descobrir
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Playlist(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _homeArtistCard() {
    return SizedBox(
      height: 120,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.all(
                Radius.circular(8),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Novo álbum',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Happier Than\nEver',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Billie Eilish',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(AppImages.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Padding(
              padding: const EdgeInsets.only(
                right: 20,
              ),
              child: Image.asset(AppImages.billieEilish),
            ),
          )
        ],
      ),
    );
  }

  Widget _tabs(BuildContext context) {
    return TabBar(
      labelColor: context.isDarkMode ? Colors.white : Colors.black,
      isScrollable: true,
      indicatorColor: AppColors.primary,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: Colors.transparent,
      tabAlignment: TabAlignment.start,
      labelStyle: const TextStyle(
        fontWeight: FontWeight.w600,
      ),
      overlayColor: MaterialStateProperty.all(Colors.grey.withOpacity(0.1)),
      controller: tabController,
      tabs: tabs
          .map(
            (e) => Tab(
              text: e,
            ),
          )
          .toList(),
    );
  }
}
