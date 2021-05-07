import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_stripe_connect/services/stripe-backend-service.dart';

class RegisterSeller extends StatefulWidget {
  @override
  _RegisterSellerState createState() => _RegisterSellerState();
}

class _RegisterSellerState extends State<RegisterSeller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register as Seller"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () async {
            ProgressDialog pd = ProgressDialog(context: context);
            pd.show(
              max: 100,
              msg: 'Please wait...',
              progressBgColor: Colors.transparent,
            );
            try {
              CreateAccountResponse response = await StripeBackendService.createSellerAccount();
              pd.close();
              await canLaunch(response.url) ? await launch(response.url) : throw 'Could not launch URL';
            } catch (e) {
              log(e.toString());
              pd.close();
            }
          },
          child: Text('Register with Stripe'),
        ),
      ),
    );
  }
}
