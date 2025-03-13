import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    final availableColors = [
      Colors.red,
      Colors.green,
      Colors.blue,
      Colors.purple,
      Colors.orange,
    ];

    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: ListView.builder(
        itemCount: availableColors.length,
        itemBuilder: (context, index){
          final color = availableColors[index];
          return ListTile(
            leading: CircleAvatar(backgroundColor: color),
            title: Text(color.toString()),
            trailing: appState.themeColor == color ? Icon(Icons.check) : null,
            onTap: () {
              appState.updateThemeColor(color);
            },
          );
        }
      ),
    );
  }
}