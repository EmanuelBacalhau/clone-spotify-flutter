import 'package:clone_spotify/common/widgets/button/basic_app_button.dart';
import 'package:clone_spotify/core/configs/assets/app_images.dart';
import 'package:clone_spotify/core/configs/assets/app_vectors.dart';
import 'package:clone_spotify/presentation/auth/pages/sign_up_or_sign_in.dart';
import 'package:clone_spotify/presentation/chose_mode/widgets/button_mode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChaseModePage extends StatelessWidget {
  const ChaseModePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.chaseModeBG),
                fit: BoxFit.fill,
              ),
            ),
          ),
          Container(
            color: Colors.black.withOpacity(0.3),
          ),
          Padding(
            padding: const EdgeInsets.all(40),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: SvgPicture.asset(AppVectors.logo),
                ),
                const Spacer(),
                const Text(
                  'Escolha o modo',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonMode(
                      title: 'Modo escuro',
                      assetName: AppVectors.moon,
                      mode: ThemeMode.dark,
                    ),
                    SizedBox(width: 40),
                    ButtonMode(
                      title: 'Modo claro',
                      assetName: AppVectors.sun,
                      mode: ThemeMode.light,
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                BasicAppButton(
                  title: 'Continuar',
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignUpOrSignInPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
