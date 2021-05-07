
import 'package:flutter/material.dart';
import 'package:flutter_stripe_connect/router/pages_config.dart';

class AppRouteParser extends RouteInformationParser<PageConfiguration> {
  @override
  Future<PageConfiguration> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location as String);
    if (uri.pathSegments.isEmpty) {
      return homePageConfig;
    }

    final path = '/' + uri.pathSegments[0];
    switch (path) {
      case RegisterPath:
        return registerPageConfig;
      case PayOutPath:
        return payOutPageConfig;
      default:
        return homePageConfig;
    }
  }

  @override
  RouteInformation restoreRouteInformation(PageConfiguration configuration) {
    switch (configuration.uiPage) {
      case Pages.Register:
        return const RouteInformation(location: RegisterPath);
      case Pages.PayOut:
        return const RouteInformation(location: PayOutPath);
      case Pages.Home:
        return const RouteInformation(location: HomePath);
      default: return const RouteInformation(location: HomePath);

    }
  }
}