import 'package:clone_spotify/common/widgets/appbar/app_bar.dart';
import 'package:clone_spotify/common/widgets/button/basic_app_button.dart';
import 'package:clone_spotify/core/configs/assets/app_vectors.dart';
import 'package:clone_spotify/core/configs/theme/app_colors.dart';
import 'package:clone_spotify/data/models/auth/auth_user_req.dart';
import 'package:clone_spotify/data/services/auth/auth_firebase_service.dart';
import 'package:clone_spotify/presentation/auth/pages/sign_up.dart';
import 'package:clone_spotify/presentation/home/pages/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInPage extends StatelessWidget {
  SignInPage({super.key});
  final AuthFirebaseService _auth = AuthFirebaseServiceImpl();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signUpText(context),
      appBar: BasicAppBar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 30,
          width: 30,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _registerText(),
              const SizedBox(height: 40),
              _emailField(),
              const SizedBox(height: 12),
              _passwordField(),
              const SizedBox(height: 12),
              BasicAppButton(
                title: 'Entrar',
                onPressed: () async {
                  var result = await _auth.signInWithEmailAndPassword(
                    AuthUserReq(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                    ),
                  );

                  result.fold(
                    (l) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            l,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          backgroundColor: Colors.red,
                        ),
                      );
                    },
                    (r) {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => HomePage(),
                        ),
                        (route) => false,
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      'Acesse sua conta',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _emailField() {
    return TextField(
      controller: _emailController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: 'E-mail',
      ),
    );
  }

  Widget _passwordField() {
    return TextField(
      controller: _passwordController,
      obscureText: true,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: 'Senha',
      ),
    );
  }

  Widget _signUpText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SignUpPage(),
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Não tem uma conta? ',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Cadastre-se',
              style: TextStyle(
                color: AppColors.primary,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
