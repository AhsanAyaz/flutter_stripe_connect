import '../app-state.dart';

const String RegisterPath = '/register';
const String PayOutPath = '/pay-out';
const String HomePath = '/home';
const String RegisterSuccessPath = '/register-success';

enum Pages { Register, PayOut, Home, RegisterSuccess, PayOutSuccess }

class PageConfiguration {
  final String key;
  final String path;
  final Pages uiPage;
  PageAction? currentPageAction;
  var extras;

  PageConfiguration(
      {required this.key,
      required this.path,
      required this.uiPage,
      this.currentPageAction});
}

PageConfiguration registerPageConfig = PageConfiguration(
    key: 'Register',
    path: RegisterPath,
    uiPage: Pages.Register,
    currentPageAction: null);
PageConfiguration payOutPageConfig = PageConfiguration(
    key: 'PayOut',
    path: PayOutPath,
    uiPage: Pages.PayOut,
    currentPageAction: null);
PageConfiguration homePageConfig = PageConfiguration(
    key: 'Home', path: HomePath, uiPage: Pages.Home, currentPageAction: null);
