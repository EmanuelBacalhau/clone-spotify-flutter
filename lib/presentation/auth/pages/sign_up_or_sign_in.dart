import 'package:clone_spotify/common/helper/is_dark_mode.dart';
import 'package:clone_spotify/common/widgets/appbar/app_bar.dart';
import 'package:clone_spotify/common/widgets/button/basic_app_button.dart';
import 'package:clone_spotify/core/configs/assets/app_images.dart';
import 'package:clone_spotify/core/configs/assets/app_vectors.dart';
import 'package:clone_spotify/core/configs/theme/app_colors.dart';
import 'package:clone_spotify/presentation/auth/pages/sign_in.dart';
import 'package:clone_spotify/presentation/auth/pages/sign_up.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpOrSignInPage extends StatelessWidget {
  const SignUpOrSignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppBar(),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(AppImages.topPattern),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Image.asset(AppImages.bottomPattern),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(AppImages.authBG),
          ),
          Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(AppVectors.logo),
                  const SizedBox(height: 30),
                  Text(
                    'Divirta-se ouvindo música',
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : AppColors.darkGrey,
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Spotify é um provedor de música digital, onde você pode ouvir milhões de músicas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: context.isDarkMode
                          ? Colors.white
                          : AppColors.darkGrey,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    children: [
                      Expanded(
                        child: BasicAppButton(
                          title: 'Cadastre-se',
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpPage(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: TextButton(
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            overlayColor: Colors.grey.withOpacity(0.1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                              side: BorderSide(
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignInPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Entrar',
                            style: TextStyle(
                              color: context.isDarkMode
                                  ? Colors.white
                                  : Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
