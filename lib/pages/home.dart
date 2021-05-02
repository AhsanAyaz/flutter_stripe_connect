import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app-state.dart';

class HomeGridItem {
  late Color color;
  Function navigate;
  late Text title;
  late Text subtitle;
  HomeGridItem(
      {required Color color,
      required this.navigate,
      required String title,
      required String subtitle}) {
    this.title = Text(title,
        style: TextStyle(fontWeight: FontWeight.w500, color: color));
    this.subtitle = Text(subtitle, style: TextStyle(color: color));
    this.color = color;
  }
}

List<HomeGridItem> gridItems = [
  new HomeGridItem(
      color: Colors.indigo[500]!,
      title: 'Register as Seller',
      subtitle: 'Register yourself as a service provider/seller',
      navigate: (AppState appState) {
        appState.goToRegister();
      }),
  new HomeGridItem(
      color: Colors.pink[500]!,
      title: 'Pay as a Customer',
      subtitle: 'Pay as a customer to the service provider',
      navigate: (AppState appState) {
        appState.goToPayOut();
      }),
];

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<InkWell> _buildCard(int count) => List.generate(count, (index) {
        final appState = Provider.of<AppState>(context, listen: false);
        HomeGridItem gridItem = gridItems.elementAt(index);
        return InkWell(
          onTap: () {
            gridItem.navigate(appState);
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
                    title: gridItem.title,
                    subtitle: Container(
                      padding: EdgeInsets.only(top: 10),
                      child: gridItem.subtitle,
                    ),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: gridItem.color,
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
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(50))
          ),
          child: Image(image: AssetImage('assets/panda-gums.png'))
        ),
        title: Text(widget.title),
      ),
      body: Center(child: _buildGrid()),
    );
  }
}
