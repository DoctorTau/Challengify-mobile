import 'package:challengify_app/src/Storage/JwtStorage.dart';
import 'package:challengify_app/src/models/challenge.dart';
import 'package:challengify_app/src/view/screens/challenge_create_screen.dart';
import 'package:challengify_app/src/view/screens/challenges_screen.dart';
import 'package:challengify_app/src/view/screens/login_screen.dart';
import 'package:challengify_app/src/view/screens/profile_screen.dart';
import 'package:challengify_app/src/web_interactors/challenge_interactor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'settings/settings_controller.dart';

/// The Widget that configures your application.
class MyApp extends StatefulWidget {
  MyApp({
    super.key,
    required this.settingsController,
  });

  final SettingsController settingsController;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ChallengeInteractor _challengeInteractor =
      ChallengeInteractor(baseUrl: dotenv.env['BASEURL']!);

  int _selectedIndex = 0;

  late Future<List<Challenge>> _challengesFuture;

  late final List<Widget> _screens = <Widget>[
    FutureBuilder(
        future: _challengesFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          } else {
            return ChallengesScreen(
                challenges: snapshot.data as List<Challenge>);
          }
        }),
    CreateChallengeScreen(
      onNavigate: () => setSelectedIndex(0),
    ),
    const ProfileScreen(),
  ];

  void setSelectedIndex(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 0) {
        _challengesFuture = _challengeInteractor.getUserChallenges();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _challengesFuture = _challengeInteractor.getUserChallenges();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''), // English, no country code
          ],
          onGenerateTitle: (BuildContext context) =>
              AppLocalizations.of(context)!.appTitle,
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: widget.settingsController.themeMode,
          routes: {
            '/profile': (context) => const ProfileScreen(),
            '/login': (context) => LoginPage(),
          },
          home: Scaffold(
            appBar: AppBar(
              title: Text("Challengify"),
            ),
            body: _screens[_selectedIndex],
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Create Challenge',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Profile',
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Theme.of(context).colorScheme.secondary,
              onTap: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        );
      },
    );
  }
}
