import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sn_progress_dialog/progress_dialog.dart';

import '../app-state.dart';

class PayOut extends StatefulWidget {
  @override
  _PayOutState createState() => _PayOutState();
}

class Product {
  String title;
  double price;
  String currency;
  Image image;

  displayCurrency() {
    switch (this.currency) {
      case 'eur':
        return '€';
      case 'usd':
        return '\$';
      default:
        return '\$';
    }
  }

  Product(
      {required this.title,
      required this.price,
      required this.currency,
      required this.image});
}

class _PayOutState extends State<PayOut> {
  List<Product> products = [
    new Product(
        title: 'Beats X',
        price: 149.95,
        currency: 'usd',
        image: Image(image: AssetImage('assets/beats-x.png'))),
    new Product(
        title: 'Arctis Pro Wireless',
        price: 340,
        currency: 'eur',
        image: Image(image: AssetImage('assets/arctis-pro-wireless.png')))
  ];

  List<InkWell> _buildCard(int count) => List.generate(count, (i) {
        final appState = Provider.of<AppState>(context, listen: false);
        String accountId = appState.accountId;
        return InkWell(
            child: Card(
                child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ListTile(
              title: Text(products[i].title),
              subtitle: Text(products[i].price.toString() +
                  ' ' +
                  products[i].displayCurrency()),
            ),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: products[i].image,
            ),
            ButtonBar(
              children: <Widget>[
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateProperty.all(
                    Theme.of(context).accentColor
                  )),
                  child: const Text('Pay with Stripe'),
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
                ),
              ],
            )
          ],
        )));
      });

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context, listen: false);
//    String accountId = appState.accountId;
    String accountId = 'dummy_1234';
    return Scaffold(
      appBar: AppBar(
        title: Text("Pay as Customer"),
        backgroundColor: Theme.of(context).accentColor,
      ),
      body: accountId != ''
          ? Container(
              padding: EdgeInsets.all(30),
              child: ListView(
                children: [
                  Container(
                      padding: EdgeInsets.only(bottom: 30),
                      child: Text('Seller Account ID = ' + accountId)),
                  ..._buildCard(2)
                ],
              ),
            )
          : Center(
              child: Text('Please register as a seller first'),
            ),
    );
  }
}
