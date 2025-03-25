import 'package:flutter/material.dart';
import 'package:namer_app/components/auth_text_field.dart';
import 'package:namer_app/controllers/auth_controller.dart';
import 'package:namer_app/main.dart';
import 'package:namer_app/pages/registration_page.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final userCredential = await _authController.login();
      if (userCredential != null) {
        // Login realizado com sucesso
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        // Tratar erro de login, exibindo uma mensagem ao usuário
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro ao fazer login. Verifique suas credenciais.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AuthTextField(
                label: 'E-mail',
                controller: _authController.emailController,
                validator: _authController.validateEmail,
              ),
              AuthTextField(
                label: 'Senha',
                controller: _authController.passwordController,
                validator: _authController.validatePassword,
                isPassword: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: Text('Entrar'),
              ),
              TextButton(onPressed: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(builder: (context) => RegistrationPage())
                );
              }, 
              child: Text('Ainda não tem conta? Cadastre-se!')),
            ],
          ),
        ),
      ),
    );
  }
}