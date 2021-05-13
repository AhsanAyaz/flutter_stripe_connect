import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_stripe_connect/app-state.dart';
import 'package:flutter_stripe_connect/router/back_dispatcher.dart';
import 'package:flutter_stripe_connect/router/pages_config.dart';
import 'package:flutter_stripe_connect/router/router_delegate.dart';
import 'package:flutter_stripe_connect/router/routes_parser.dart';
import 'package:provider/provider.dart';
import 'package:uni_links/uni_links.dart';


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

  late StreamSubscription _linkSubscription;

  _MyAppState() {
    delegate = AppRouterDelegate(appState);
    delegate.setNewRoutePath(homePageConfig);
    backButtonDispatcher = AppBackButtonDispatcher(delegate);
  }

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  @override
  void dispose() {
    _linkSubscription.cancel();
    super.dispose();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    // Attach a listener to the Uri links stream
    _linkSubscription = uriLinkStream.listen((Uri? uri) {
      if (!mounted) return;
      setState(() {
        delegate.parseRoute(uri!);
      });
    }, onError: (Object err) {
      print('Got error $err');
    });
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
