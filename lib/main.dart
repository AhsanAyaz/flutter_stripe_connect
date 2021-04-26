import 'package:flutter/material.dart';
import 'package:flutter_stripe_connect/pages/pay-out.dart';
import 'package:flutter_stripe_connect/pages/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Stripe Connect',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        accentColor: Colors.pink
      ),
      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        '/': (context) => MyHomePage(title: 'Flutter Stripe Connect'),
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/register': (context) => RegisterSeller(),
        '/pay-out': (context) => PayOut(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<InkWell> _buildCard(int count) => List.generate(count, (i) {
        Color? color = i == 0 ? Colors.indigo[500] : Colors.pink[500];
        String routeName = i == 0 ? '/register' : '/pay-out';
        return InkWell(
          onTap: () {
            Navigator.pushNamed(context, routeName);
          },
          child: Container(
              child: SizedBox(
            height: 210,
            child: Card(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                    title: Text(
                        i == 0 ? 'Register as Seller' : 'Pay as a Customer',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, color: color)),
                    subtitle: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                          i == 0
                              ? 'Register yourself as a service provider/seller'
                              : 'Pay as a customer to the service provider',
                          style: TextStyle(color: color)),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: color,
                    ))
              ],
            )),
          )),
        );
      });

  Widget _buildGrid() => GridView.extent(
      maxCrossAxisExtent: 200,
      padding: const EdgeInsets.all(4),
      mainAxisSpacing: 4,
      crossAxisSpacing: 4,
      children: _buildCard(2));

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child: _buildGrid()
      ),
    );
  }
}
