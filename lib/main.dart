import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/pages/banned_words_page.dart';
import 'package:namer_app/pages/favorites_page.dart';
import 'package:namer_app/pages/generator_page.dart';
import 'package:namer_app/pages/login_page.dart';
import 'package:namer_app/pages/settings_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: Consumer<MyAppState>(
        builder: (context, appState, child){
          return MaterialApp(
            title: 'Namer App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(seedColor: appState.themeColor),
            ),
            home: LoginPage(),
          );
        },
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  double themeHue = 0.0;
  Color get themeColor => HSVColor.fromAHSV(1, themeHue, 1, 1).toColor();
  
  var current = WordPair.random();
  var history = <WordPair>[];
  var favorites = <WordPair>[];
  var bannedWords = <String>[];

  GlobalKey? historyListKey;

  void getNext() {
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    do {
      current = WordPair.random();
    } while (bannedWords.contains(current.first) || bannedWords.contains(current.second));
    animatedList?.insertItem(0);
    notifyListeners();
  }

    void updateFirstWord(){
    String newFirst;
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    do{
      newFirst = WordPair.random().first;
    } while (bannedWords.contains(newFirst));
    current = WordPair(newFirst, current.second);
    animatedList?.insertItem(0);
    notifyListeners();
  }

  void updateSecondWord(){
    String newSecond;
    history.insert(0, current);
    var animatedList = historyListKey?.currentState as AnimatedListState?;
    do{
      newSecond = WordPair.random().second;
    } while (bannedWords.contains(newSecond));
    current = WordPair(current.first, newSecond);
    animatedList?.insertItem(0);
    notifyListeners();
  }

  void toggleFavorite([WordPair? pair]) {
    pair = pair ?? current;
    if (favorites.contains(pair)) {
      favorites.remove(pair);
    } else {
      favorites.add(pair);
    }
    notifyListeners();
  }

  void removeFavorite(WordPair pair) {
    favorites.remove(pair);
    notifyListeners();
  }

  void addBannedWord(String word) {
    if (!bannedWords.contains(word)) {
      bannedWords.add(word.toLowerCase());
      notifyListeners();
    }
  }

  void removeBannedWord(String word) {
    bannedWords.remove(word.toLowerCase());
    notifyListeners();
  }

  void updateThemeHue(double newHue){
    themeHue = newHue;
    notifyListeners();
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    var colorScheme = Theme.of(context).colorScheme;

    Widget page;
    switch (selectedIndex) {
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritesPage();
        break;
      case 2:
        page = BannedWordsPage();
        break;
      default:
        throw UnimplementedError('No widget for $selectedIndex');
    }

    var mainArea = ColoredBox(
      color: colorScheme.surfaceContainerHighest,
      child: AnimatedSwitcher(
        duration: Duration(milliseconds: 200),
        child: page,
      ),
    );

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.settings),
        onPressed: (){
          Navigator.push(
            context, 
            MaterialPageRoute(builder: (context) => SettingsPage()),
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth < 450) {
            return Column(
              children: [
                Expanded(child: mainArea),
                SafeArea(
                  child: BottomNavigationBar(
                    items: [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.favorite),
                        label: 'Favorites',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.block),
                        label: 'Banned',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    onTap: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                )
              ],
            );
          } else {
            return Row(
              children: [
                SafeArea(
                  child: NavigationRail(
                    extended: constraints.maxWidth >= 600,
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.home),
                        label: Text('Home'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.favorite),
                        label: Text('Favorites'),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.block),
                        label: Text('Banned Words'),
                      ),
                    ],
                    selectedIndex: selectedIndex,
                    onDestinationSelected: (value) {
                      setState(() {
                        selectedIndex = value;
                      });
                    },
                  ),
                ),
                Expanded(child: mainArea),
              ],
            );
          }
        },
      ),
    );
  }
}
