import 'package:flutter/material.dart';
import 'package:flutter_stripe_connect/app-state.dart';
import 'package:flutter_stripe_connect/router/back_dispatcher.dart';
import 'package:flutter_stripe_connect/router/pages_config.dart';
import 'package:flutter_stripe_connect/router/router_delegate.dart';
import 'package:flutter_stripe_connect/router/routes_parser.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final appState = AppState();
  late AppRouterDelegate delegate;
  final parser = AppRouteParser();
  late AppBackButtonDispatcher backButtonDispatcher;

  _MyAppState() {
    delegate = AppRouterDelegate(appState);
    delegate.setNewRoutePath(homePageConfig);
    backButtonDispatcher = AppBackButtonDispatcher(delegate);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppState>(
      create: (_) => appState,
      child: MaterialApp.router(
        title: 'Panda Gums',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.pink,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        backButtonDispatcher: backButtonDispatcher,
        routerDelegate: delegate,
        routeInformationParser: parser,
      ),
    );
  }
}
