import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../constants.dart';

String checkoutSuccessUrl = '$BACKEND_HOST/pay-out-mobile?result=success';
String checkoutFailureUrl = '$BACKEND_HOST/pay-out-mobile?result=failure';
String stripePublicKey = 'pk_test_EYFzViclTJlQjgVjGSA4ND7k00wUh0e1tK';

const stripeHtmlPageScaffold = '''
  <!DOCTYPE html>
  <html>
    <script src="https://js.stripe.com/v3/"></script>
    <style>
      body, html {
        width: 100%;
        height: 100%;
        margin: 0;
        padding: 0;
      }
      #loader {
        width: 100%;
        height: 100%;
        display: flex;
        justify-content: center;
        align-items: center; 
      }
    </style>
    <head><title>Stripe checkout</title></head>
    <body>
      <div id="loader">
        <span>Please wait...</span>
      </div>
    </body>
  </html>
''';

class CheckoutPage extends StatefulWidget {
  final String sessionId;

  const CheckoutPage({Key? key, required this.sessionId}) : super(key: key);

  @override
  _CheckoutPageState createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late WebViewController _controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: 30),
        child: WebView(
          initialUrl: initialUrl,
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (controller) => _controller = controller,
          onPageFinished: (String url) {
            if (url == initialUrl) {
              _redirectToStripe();
            }
          },
          navigationDelegate: (NavigationRequest request) {
            if (request.url.startsWith(checkoutSuccessUrl)) {
              Navigator.of(context).pop('success'); // <-- Handle success case
            } else if (request.url.startsWith(checkoutFailureUrl)) {
              Navigator.of(context).pop('cancel'); // <-- Handle cancel case
            }
            return NavigationDecision.navigate;
          },
        ),
      ),
    );
  }

  String get initialUrl => 'data:text/html;base64,${base64Encode(Utf8Encoder().convert(stripeHtmlPageScaffold))}';

  void _redirectToStripe() {
    final redirectToCheckoutJs = '''
      var stripe = Stripe(\'$stripePublicKey\');
      stripe.redirectToCheckout({
        sessionId: '${widget.sessionId}'
      }).then(function (result) {
        result.error.message = 'Error'
      });
    ''';
    _controller.evaluateJavascript(redirectToCheckoutJs); //<--- call the JS function on controller
  }
}
