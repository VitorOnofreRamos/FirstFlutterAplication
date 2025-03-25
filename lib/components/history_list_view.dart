import 'package:flutter/material.dart';
import 'package:namer_app/main.dart';
import 'package:provider/provider.dart';

class HistoryListView extends StatefulWidget {
  const HistoryListView({super.key});

  @override
  State<HistoryListView> createState() => _HistoryListViewState();
}

class _HistoryListViewState extends State<HistoryListView> {
  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();

  static const Gradient _maskingGradient = LinearGradient(
    colors: [Colors.transparent, Colors.black],
    stops: [0.0, 0.5],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  void _removeItem(BuildContext context, int index) {
    final appState = context.read<MyAppState>();
    final pair = appState.history[index];

    appState.history.removeAt(index);

    _listKey.currentState?.removeItem(
      index,
      (context, animation) => SizeTransition(
        sizeFactor: animation,
        child: Container(),
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pair.asPascalCase} removido do histórico'),
        action: SnackBarAction(
          label: 'Desfazer', 
          onPressed: (){
            appState.history.insert(index, pair);
            _listKey.currentState?.insertItem(index);
          }
        ),
        duration: Duration(seconds: 4),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final appState = context.watch<MyAppState>();
    appState.historyListKey = _listKey;
    var theme = Theme.of(context);

    return ShaderMask(
      shaderCallback: (bounds) => _maskingGradient.createShader(bounds),
      blendMode: BlendMode.dstIn,
      child: AnimatedList(
        key: _listKey,
        reverse: true,
        padding: EdgeInsets.only(top: 100),
        initialItemCount: appState.history.length,
        itemBuilder: (context, index, animation) {
          final pair = appState.history[index];
          return SizeTransition(
            sizeFactor: animation,
            child: GestureDetector(
              onSecondaryTap: () => _removeItem(context, index), // Clique direito remove
              child: Dismissible(
                key: ValueKey(pair.asPascalCase),
                background: Container(color: theme.colorScheme.onErrorContainer),
                onDismissed: (direction) => _removeItem(context, index), // Swipe também remove
                child: Center(
                  child: TextButton.icon(
                    onPressed: () {
                      appState.toggleFavorite(pair);
                    },
                    icon: appState.favorites.contains(pair)
                        ? Icon(Icons.favorite, size: 12)
                        : SizedBox(),
                    label: Text(
                      pair.asLowerCase,
                      semanticsLabel: pair.asPascalCase,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
