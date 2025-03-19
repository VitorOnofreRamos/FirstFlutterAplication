import 'package:flutter/material.dart';
 import 'package:namer_app/main.dart';
 
 class LoginPage extends StatefulWidget{
   @override
   LoginPageState createState() => LoginPageState();
 }
 
 class LoginPageState extends State<LoginPage> {
   final _formKey = GlobalKey<FormState>();
   String _email = '';
   String _password = '';
 
   void _submit() {
     if (_formKey.currentState!.validate()) {
       // Se os campos forem válidos, navegue para a página principal
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
               TextFormField(
                 decoration: InputDecoration(labelText: 'E-mail'),
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Por favor, insira seu e-mail';
                   }
                   return null;
                 },
                 onSaved: (value) {
                   _email = value!;
                 },
               ),
               TextFormField(
                 decoration: InputDecoration(labelText: 'Senha'),
                 obscureText: true,
                 validator: (value) {
                   if (value == null || value.isEmpty) {
                     return 'Por favor, insira sua senha';
                   }
                   return null;
                 },
                 onSaved: (value) {
                   _password = value!;
                 },
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