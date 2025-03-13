import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class BannedWordsPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);
    var appState = context.watch<MyAppState>();
    var controller = TextEditingController();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('You have '
              '${appState.bannedWords.length} banned words:'),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: 'Digite uma palavra',
                      ),
                    ),
                  ),
                  IconButton(icon: Icon(Icons.add),
                    onPressed: () {
                      if (controller.text.trim().isNotEmpty){
                        appState.addBannedWord(controller.text.trim());
                        controller.clear();
                      }
                    },
                  )
                ],
              )
            ],
          ),
        ),
        if(appState.bannedWords.isEmpty)
        SizedBox(
          child: Center(
            child: Text('No banned words yet.'),
          ),
        ),
        Expanded(
          child: GridView(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 400,
              childAspectRatio: 400 / 80,
            ),
            children: [
              for (var word in appState.bannedWords)
              ListTile(
                leading: IconButton(
                  icon: Icon(Icons.delete_outline, semanticLabel: 'Delete'),
                  color: theme.colorScheme.primary,
                  onPressed: () {
                    appState.removeBannedWord(word);
                  },
                ),
                title: Text(word),
              )
            ],
          ),
        )
      ],
    );
  }
}