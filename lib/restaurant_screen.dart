import 'package:flutter/material.dart';

import './restaurantCard.dart';
import './screen.dart';

final Screen restaurantScreen = Screen(
  title: 'THE PALEO PODLOCK',
  background: DecorationImage(
              image: AssetImage('assets/wood_bkg.jpg'), fit: BoxFit.cover),
  contentBuilder: (BuildContext context) {
    return ListView(
          children: <Widget>[
            RestaurantCard(
              'assets/skillet-baked-eggs.jpg',
              Icons.fastfood,
              Colors.orange,
              'baked eggs',
              '78 5TH AVENUE, NEW YORK',
              84
            ),
            RestaurantCard(
              'assets/pancakes.jpg',
              Icons.local_dining,
              Colors.red,
              'fluffy pancakes',
              '79 5TH AVENUE, NEW YORK',
              33
            ),
            RestaurantCard(
              'assets/spices.jpg',
              Icons.fastfood,
              Colors.purpleAccent,
              'spoons of spices',
              '12 6TH AVENUE, NEW YORK',
              101
            ),
            RestaurantCard(
              'assets/litti_chokha.jpg',
              Icons.fastfood,
              Colors.greenAccent,
              'litti chokha',
              '74 6TH AVENUE, NEW YORK',
              101
            ),
            // RestaurantCard('assets/litti_chokha.jpg'),
          ],
        );
  }
);
