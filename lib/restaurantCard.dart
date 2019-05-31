import 'package:flutter/material.dart';

class RestaurantCard extends StatelessWidget {
  final String headerImageAssetPath;
  final IconData icon;
  final Color iconBackgroundColor;
  final String title;
  final String subtitle;
  final int heartCount;

  RestaurantCard(
    this.headerImageAssetPath,
    this.icon,
    this.iconBackgroundColor,
    this.title,
    this.subtitle,
    this.heartCount
  );

  _buildFoodImage() {
    return Image.asset(
      headerImageAssetPath,
      width: double.infinity, // as large as it can be
      height: 150.0,
      fit: BoxFit.cover, // ask the image to cover the available space
    );
  }

  _buildFastFoodIcon() {
    return Padding(
      padding: EdgeInsets.all(15.0),
      child: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            color: iconBackgroundColor,
            borderRadius: BorderRadius.all(Radius.circular(15.0))),
        child: Icon(
          icon, 
          color: Colors.white
        ),
      ),
    );
  }

  _buildTitleSubtitle() {
    return Expanded(
      // need this so that the divider gets pushed to the right
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 20.0, fontFamily: 'mermaid'),
          ),
          Text(
            subtitle,
            style: TextStyle(
                fontSize: 14.0,
                fontFamily: 'bebas-neue',
                letterSpacing: 1.0,
                color: Color(0xFFAAAAAA)),
          )
        ],
      ),
    );
  }

  _buildLinearGradient() {
    return Container(
      width: 2.0,
      height: 70.0,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.white,
        Colors.white,
        Color(0xFFAAAAAA),
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
    );
  }

  _buildFavorite() {
    return Padding(
      padding: EdgeInsets.only(left: 15.0, right: 15.0),
      child: Column(
        children: <Widget>[
          Icon(
            Icons.favorite_border,
            color: Colors.red,
          ),
          Text(heartCount.toString())
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
      child: Card(
        elevation: 10.0,
        child: Column(
          children: <Widget>[
            _buildFoodImage(),
            Row(
              children: <Widget>[
                _buildFastFoodIcon(),
                _buildTitleSubtitle(),
                _buildLinearGradient(),
                _buildFavorite()
              ],
            )
          ],
        ),
      ),
    );
  }
}
