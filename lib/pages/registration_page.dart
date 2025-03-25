import 'package:flutter/material.dart';
import 'package:namer_app/components/auth_text_field.dart';
import 'package:namer_app/controllers/auth_controller.dart';
import 'package:namer_app/pages/login_page.dart';

class RegistrationPage extends StatefulWidget {
  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  final AuthController _authController = AuthController();
  
  // Controladores para os campos adicionais
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();

  void _register() async {
    if (_formKey.currentState!.validate()) {
      final userCredential = await _authController.register(
        name: _nameController.text.trim(),
        age: _ageController.text.trim(),
      );
      if (userCredential != null) {
        // Cadastro realizado com sucesso, redireciona para a tela de login
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro no cadastro. Tente novamente.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cadastro")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: "Nome"),
                validator: (value) =>
                    value == null || value.isEmpty ? "Insira seu nome" : null,
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(labelText: "Idade"),
                keyboardType: TextInputType.number,
                validator: (value) =>
                    value == null || value.isEmpty ? "Insira sua idade" : null,
              ),
              // Os campos de e-mail e senha já estão no AuthController
              AuthTextField(
                label: "E-mail",
                controller: _authController.emailController,
                validator: _authController.validateEmail,
              ),
              AuthTextField(
                label: "Senha",
                controller: _authController.passwordController,
                validator: _authController.validatePassword,
                isPassword: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text("Cadastrar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
