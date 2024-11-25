import 'package:clone_spotify/common/widgets/appbar/app_bar.dart';
import 'package:clone_spotify/common/widgets/button/basic_app_button.dart';
import 'package:clone_spotify/core/configs/assets/app_vectors.dart';
import 'package:clone_spotify/core/configs/theme/app_colors.dart';
import 'package:clone_spotify/data/models/auth/create_user_req.dart';
import 'package:clone_spotify/data/services/auth/auth_firebase_service.dart';
import 'package:clone_spotify/presentation/auth/pages/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});

  final AuthFirebaseService _authFirebaseService = AuthFirebaseServiceImpl();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: _signInText(context),
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
              _fullNameField(),
              const SizedBox(height: 12),
              _emailField(),
              const SizedBox(height: 12),
              _passwordField(),
              const SizedBox(height: 12),
              BasicAppButton(
                title: 'Criar conta',
                onPressed: () async {
                  var result =
                      await _authFirebaseService.createUserWithEmailAndPassword(
                    CreateUserReq(
                      email: _emailController.text.trim(),
                      password: _passwordController.text.trim(),
                      fullName: _fullNameController.text.trim(),
                    ),
                  );

                  result.fold(
                    (l) => {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l),
                          backgroundColor: Colors.red,
                        ),
                      ),
                    },
                    (r) => {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => SignInPage(),
                        ),
                      )
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
      'Cadastre-se',
      style: TextStyle(
        fontSize: 26,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _fullNameField() {
    return TextField(
      controller: _fullNameController,
      decoration: const InputDecoration(
        hintText: 'Nome completo',
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
      obscureText: true,
      controller: _passwordController,
      keyboardType: TextInputType.emailAddress,
      decoration: const InputDecoration(
        hintText: 'Senha',
      ),
    );
  }

  Widget _signInText(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SignInPage(),
          ),
        );
      },
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Já tem uma conta?',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(width: 4),
            Text(
              'Entrar',
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
