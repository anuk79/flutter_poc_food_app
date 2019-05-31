import 'package:flutter/material.dart';

import './screen.dart';

final Screen otherScreen = Screen(
    title: 'OTHER SCREEN',
    background: DecorationImage(
        image: AssetImage('assets/veg1.jpg'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(Color(0xCC000000), BlendMode.multiply)),
    contentBuilder: (BuildContext context) {
      return Center(
          child: Container(
              height: 350.0,
              child: Padding(
                padding: EdgeInsets.all(25.0),
                child: Card(
                  child: Column(
                    children: <Widget>[
                      Image.asset('assets/vegetables.jpeg'),
                      Expanded(
                        child: Center(
                          child: Text('This is another screen'),
                        ),
                      ),
                    ],
                  ),
                ),
              )));
    });
