import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './models/models.dart';
import './theme/theme.dart';
import './navigation/app_router.dart';

void main() => runApp(const App());

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final AppStateManager _appStateManager = AppStateManager();
  //has to be added over app router to make sure hero animation is working correctly
  final HeroController _heroController = HeroController();
  late AppRouter _appRouter;

  @override
  void initState() {
    _appRouter = AppRouter(
      appStateManager: _appStateManager,
      heroController: _heroController,
    );

    super.initState();
  }

  @override
  void dispose() {
    _appRouter.dispose();
    _appStateManager.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => _appStateManager,
      child: MaterialApp(
        title: 'NFT Market demo',
        theme: appTheme,
        home: Router(
          routerDelegate: _appRouter,
          backButtonDispatcher: RootBackButtonDispatcher(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
