import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe_connect/app-state.dart';
import 'package:flutter_stripe_connect/pages/home.dart';
import 'package:flutter_stripe_connect/pages/pay-out.dart';
import 'package:flutter_stripe_connect/pages/register-success.dart';
import 'package:flutter_stripe_connect/pages/register.dart';
import 'package:flutter_stripe_connect/router/pages_config.dart';
import 'back_dispatcher.dart';

class AppRouterDelegate extends RouterDelegate<PageConfiguration>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<PageConfiguration> {
  final List<MaterialPage> _pages = [];
  late AppBackButtonDispatcher backButtonDispatcher;

  @override
  final GlobalKey<NavigatorState> navigatorKey;
  final AppState appState;

  AppRouterDelegate(this.appState) : navigatorKey = GlobalKey() {
    appState.addListener(() {
      notifyListeners();
    });
  }

  /// Getter for a list that cannot be changed
  List<MaterialPage> get pages => List.unmodifiable(_pages);

  /// Number of pages function
  int numPages() => _pages.length;

  @override
  PageConfiguration get currentConfiguration =>
      _pages.last.arguments as PageConfiguration;

  @override
  Widget build(BuildContext context) {
    return Navigator(
      key: navigatorKey,
      onPopPage: _onPopPage,
      pages: buildPages(),
    );
  }

  bool _onPopPage(Route<dynamic> route, result) {
    final didPop = route.didPop(result);
    if (!didPop) {
      return false;
    }
    if (canPop()) {
      pop();
      return true;
    } else {
      return false;
    }
  }

  void pop() {
    if (canPop()) {
      _removePage(_pages.last);
    }
  }

  void _removePage(MaterialPage? page) {
    if (page != null) {
      _pages.remove(page);
    }
  }

  bool canPop() {
    return _pages.length > 1;
  }

  MaterialPage _createPage(Widget child, PageConfiguration pageConfig) {
    return MaterialPage(
        child: child,
        key: ValueKey(pageConfig.key),
        name: pageConfig.path,
        arguments: pageConfig);
  }

  void replace(PageConfiguration newRoute) {
    if (_pages.isNotEmpty) {
      _pages.removeLast();
    }
    addPage(newRoute);
  }

  void setPath(List<MaterialPage> path) {
    _pages.clear();
    _pages.addAll(path);
  }

  void replaceAll(PageConfiguration newRoute) {
    setNewRoutePath(newRoute);
  }

  void push(PageConfiguration newRoute) {
    addPage(newRoute);
  }

  void addAll(List<PageConfiguration> routes) {
    _pages.clear();
    routes.forEach((route) {
      addPage(route);
    });
  }

  @override
  Future<void> setNewRoutePath(PageConfiguration configuration) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            configuration.uiPage;
    if (shouldAddPage) {
      _pages.clear();
      addPage(configuration);
    }
    return SynchronousFuture(null);
  }

  void addPage(PageConfiguration pageConfig) {
    final shouldAddPage = _pages.isEmpty ||
        (_pages.last.arguments as PageConfiguration).uiPage !=
            pageConfig.uiPage;
    if (shouldAddPage) {
      switch (pageConfig.uiPage) {
        case Pages.Home:
          _pages.add(
            _createPage(MyHomePage(title: 'Panda Gums'), pageConfig),
          );
          break;
        case Pages.Register:
          _pages.add(
            _createPage(RegisterSeller(), pageConfig),
          );
          break;
        case Pages.PayOut:
          _pages.add(
            _createPage(PayOut(), pageConfig),
          );
          break;
        default:
          break;
      }
    }
  }

  void _setPageAction(PageAction action) {
    switch (action.page!.uiPage) {
      case Pages.Home:
        homePageConfig.currentPageAction = action;
        break;
      case Pages.Register:
        registerPageConfig.currentPageAction = action;
        break;
      case Pages.PayOut:
        payOutPageConfig.currentPageAction = action;
        break;
      default:
        break;
    }
  }

  List<Page> buildPages() {
    switch (appState.currentAction.state) {
      case PageState.none:
        break;
      case PageState.addPage:
        _setPageAction(appState.currentAction);
        addPage(appState.currentAction.page as PageConfiguration);
        break;
      case PageState.replace:
        _setPageAction(appState.currentAction);
        replace(appState.currentAction.page as PageConfiguration);
        break;
      case PageState.replaceAll:
        _setPageAction(appState.currentAction);
        replaceAll(appState.currentAction.page as PageConfiguration);
        break;
      case PageState.addAll:
        addAll(appState.currentAction.pages as List<PageConfiguration>);
        break;
      default:
        break;
    }
    appState.resetCurrentAction();
    return List.of(_pages);
  }

  void parseRoute(Uri uri) {
    if (uri.pathSegments.isEmpty) {
      setNewRoutePath(homePageConfig);
      return;
    }
    if (uri.pathSegments.length == 1) {
      final path = uri.pathSegments[0];
      switch (path) {
        case 'home':
          replaceAll(homePageConfig);
          break;
        case 'register':
          push(registerPageConfig);
          break;
        case 'pay-out':
          push(payOutPageConfig);
          break;
        case 'register-success':
          registerSuccessPageConfig.extras = new Map<String, dynamic>();
          registerSuccessPageConfig.extras['account_id'] = uri.queryParameters['account_id'];
          _pages.add(MaterialPage(
              child: RegisterSuccessPage(),
              key: ValueKey(registerSuccessPageConfig.key),
              name: registerSuccessPageConfig.path,
              arguments: registerSuccessPageConfig));
          break;
      }
    }
  }
}
