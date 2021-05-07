

import 'package:flutter/material.dart';
import 'package:flutter_stripe_connect/router/pages_config.dart';

enum PageState {
  none,
  addPage,
  addAll,
  addWidget,
  pop,
  replace,
  replaceAll
}

class PageAction {
  PageState state;
  PageConfiguration? page;
  List<PageConfiguration>? pages;
  Widget? widget;

  PageAction({this.state = PageState.none, this.page, this.pages, this.widget});
}
class AppState extends ChangeNotifier {
  PageAction _currentAction = PageAction();
  PageAction get currentAction => _currentAction;
  set currentAction(PageAction action) {
    _currentAction = action;
    notifyListeners();
  }
  String _accountId = 'dummy_1234';
  String get accountId => _accountId;
  set accountId(String id) {
    _accountId = id;
    notifyListeners();
  }

  AppState();

  void goToRegister() {
    _currentAction = PageAction(state: PageState.addPage, page: registerPageConfig);
    notifyListeners();
  }

  void goToPayOut() {
    _currentAction = PageAction(state: PageState.addPage, page: payOutPageConfig);
    notifyListeners();
  }

  void resetCurrentAction() {
    _currentAction = PageAction();
  }

}