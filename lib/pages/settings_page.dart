import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var theme = Theme.of(context);

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
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(200),
                    color: theme.colorScheme.primary,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 2.0,
                        blurRadius: 10.0,
                        color: Colors.black26,
                      ),
                    ],
                  ),
                  width: 70,
                  height: 70,
                ),
                Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: theme.colorScheme.inversePrimary,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2.0,
                          blurRadius: 10.0,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    width: 35,
                    height: 35,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(200),
                      color: theme.colorScheme.inverseSurface,
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 2.0,
                          blurRadius: 10.0,
                          color: Colors.black26,
                        ),
                      ],
                    ),
                    width: 35,
                    height: 35,
                  ),
                ],)
              ],
            ),
            SizedBox(height: 20),
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