import 'package:flutter/material.dart';

import '../models/models.dart';
import '../screens/screens.dart';

class AppRouter extends RouterDelegate
    with ChangeNotifier, PopNavigatorRouterDelegateMixin {
  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppStateManager appStateManager;
  final HeroController heroController;

  AppRouter({
    required this.appStateManager,
    required this.heroController,
  }) : navigatorKey = GlobalKey<NavigatorState>() {
    appStateManager.addListener(notifyListeners);
  }

  @override
  Future<void> setNewRoutePath(configuration) => Future.value();

  bool _handlePop(Route<dynamic> route, result) {
    if (!route.didPop(result)) {
      return false;
    }

    if (route.settings.name == '/details') {
      appStateManager.changeSelectedPost(null);
    }

    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _handlePop,
      pages: [
        HomeScreen.page(),
        if (!appStateManager.isOnboardingComplete) OnboardingScreen.page(),
        if (appStateManager.hasSelectedPost)
          PostDetailScreen.page(appStateManager.selectedPost),
      ],
      observers: [
        heroController,
      ],
    );
  }

  @override
  void dispose() {
    appStateManager.removeListener(notifyListeners);

    super.dispose();
  }
}
