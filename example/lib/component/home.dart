import 'package:flutter/material.dart';
import 'package:lazy_flutter_component/src/component/echarts.dart';


class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text('home'),
          ),
          Container(
            height: 400,
            child: Center(
              child: Echarts(),
            ),
          )
        ],
      ),
    );
  }
}
