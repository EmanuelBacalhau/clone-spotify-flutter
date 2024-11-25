import 'package:clone_spotify/data/models/auth/auth_user_req.dart';
import 'package:clone_spotify/data/models/auth/create_user_req.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthFirebaseService {
  Future<Either> signInWithEmailAndPassword(AuthUserReq data);
  Future<Either> createUserWithEmailAndPassword(CreateUserReq data);
  void signOut();
}

class AuthFirebaseServiceImpl implements AuthFirebaseService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<Either> createUserWithEmailAndPassword(CreateUserReq data) async {
    try {
      final UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
              email: data.email.trim(), password: data.password.trim());

      User? user = userCredential.user;

      await _firestore.collection('users').doc(user!.uid).set({
        'fullName': data.fullName.trim(),
        "email": data.email.trim(),
      });

      return const Right('Conta criada com sucesso!');
    } on FirebaseAuthException catch (e) {
      String message = '';

      if (e.code == 'weak-password') {
        message = 'Senha muito fraca.';
      } else if (e.code == 'email-already-in-use') {
        message = 'E-mail já cadastrado.';
      }

      return Left(message);
    }
  }

  @override
  Future<Either> signInWithEmailAndPassword(AuthUserReq data) async {
    try {
      await _auth.signInWithEmailAndPassword(
        email: data.email.trim(),
        password: data.password.trim(),
      );

      return const Right('Login realizado com sucesso!');
    } on FirebaseAuthException catch (e) {
      return const Left('E-mail ou senha inválidos');
    }
  }

  @override
  void signOut() {
    _auth.signOut();
  }
}
