import 'package:flutter/material.dart';
import 'package:namer_app/components/auth_text_field.dart';
import 'package:namer_app/controllers/auth_controller.dart';
import 'package:namer_app/main.dart';

class LoginPage extends StatefulWidget{
  @override
  LoginPageState createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MyHomePage()),
      );
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
            ],
          ),
        ),
      ),
    );
  }
}