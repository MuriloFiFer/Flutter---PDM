import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Layout Básico',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Layout Básico'),
        ),
        body: Center(
          child: Container(
            color: Colors.grey[200],
            padding: EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Este é um exemplo de layout básico',
                  style: TextStyle(fontSize: 18.0),
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.star, color: Colors.yellow),
                    Text('Widget 1'),
                  ],
                ),
                SizedBox(height: 20.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Icon(Icons.favorite, color: Colors.red),
                    Text('Widget 2'),
                  ],
                ),
                SizedBox(height: 20.0),
                Image.network(
                  'https://via.placeholder.com/150',
                  width: 150.0,
                  height: 150.0,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
