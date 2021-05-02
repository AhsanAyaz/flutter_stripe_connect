import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

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
          // Within the SecondScreen widget
          onPressed: () async {
            ProgressDialog pd = ProgressDialog(context: context);
            pd.show(
              max: 100,
              msg: 'Please wait...',
              progressBgColor: Colors.transparent,
            );
            try {
              Future.delayed(Duration(milliseconds: 2000), () {
                pd.close();
              });
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
