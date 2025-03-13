import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();

    return Scaffold(
      appBar: AppBar(title: Text('Configurações')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              'Ajuste a cor do tema (HUE)',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            SizedBox(height: 20),
            // Exibe um preview da cor selecionada
            CircleAvatar(
              backgroundColor: appState.themeColor,
              radius: 40,
            ),
            SizedBox(height: 20),
            // Slider que altera a HUE
            Slider(
              min: 0.0,
              max: 360.0,
              value: appState.themeHue,
              label: '${appState.themeHue.round()}°',
              onChanged: (newHue) {
                appState.updateThemeHue(newHue);
              },
            ),
          ],
        ),
      ),
    );
  }
}