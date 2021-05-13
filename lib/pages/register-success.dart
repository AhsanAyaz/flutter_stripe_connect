import 'package:flutter/material.dart';
import 'package:flutter_stripe_connect/app-state.dart';
import 'package:flutter_stripe_connect/router/pages_config.dart';
import 'package:provider/provider.dart';

class RegisterSuccessPage extends StatefulWidget {
  @override
  _RegisterSellerState createState() => _RegisterSellerState();
}

class _RegisterSellerState extends State<RegisterSuccessPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    PageConfiguration routeArgs = ModalRoute.of(context)!.settings.arguments as PageConfiguration;
    Map<String, dynamic> extras = routeArgs.extras as Map<String, dynamic>;
    final appState = Provider.of<AppState>(context, listen: false);
    Future.delayed(Duration(seconds: 1), () {
      appState.accountId = extras['account_id'];
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Register as Seller"),
      ),
      body: Center(
        child: Text('Registration Successful'),
      ),
    );
  }
}
