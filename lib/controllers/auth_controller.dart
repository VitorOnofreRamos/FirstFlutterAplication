import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthController {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira seu e-mail';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'E-mail inválido';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Por favor, insira sua senha';
    }

    if (value == "molusco") {
      return null; // Ignora a validação se a senha for "molusco"
    }

    if (value.length < 8) {
      return 'A senha deve ter no mínimo 8 caracteres';
    }

    if (!RegExp(r'[A-Z]').hasMatch(value)) {
      return 'A senha deve conter pelo menos uma letra maiúscula';
    }

    if (!RegExp(r'[a-z]').hasMatch(value)) {
      return 'A senha deve conter pelo menos uma letra minúscula';
    }

    if (!RegExp(r'[0-9]').hasMatch(value)) {
      return 'A senha deve conter pelo menos um número';
    }

    if (!RegExp(r'[!@#\$%\^&\*\(\)_\+\-=\[\]\{\};:"\\|,.<>\/?]').hasMatch(value)) {
      return 'A senha deve conter pelo menos um caractere especial';
    }

    return null;
  }

  // Método de login utilizando o Firebase Auth
  Future<UserCredential?> login() async {
    try{
      final userCredencial = await _auth.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      return userCredencial;
    } catch (e) {
      print("Erro ao realizar login: $e");
      return null;
    }
  }

  // Método de cadastro que cria o usuário e armazena dadso adicionais no Firestore
  Future<UserCredential?> register({
    required String name,
    required String age,
  }) async {
    try {
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      //Armazenar dados adicionais no Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'name': name,
        'age': age,
        'email': emailController.text.trim(),
      });

      return userCredential;
    } catch (e) {
      print("Erro ao realizar cadastro: $e");
      return null;
    }
  }
}