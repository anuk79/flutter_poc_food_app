import 'package:flutter/material.dart';

import './zoom_scaffold.dart';

class MenuScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MenuScreenState();
  }
}

class _MenuScreenState extends State<MenuScreen> {
  _buildMenuItems(MenuController menuController) {
    return Transform(
      transform: Matrix4.translationValues(0.0, 280.0, 0.0),
      child: Column(
        children: <Widget>[
          MenuListItem(
            title: 'THE PADDOCK',
            isSelected: true,
            onTap: () {
              menuController.close();
            },
          ),
          MenuListItem(
            title: 'THE HERO',
            isSelected: false,
            onTap: () {
              menuController.close();
            },
          ),
          MenuListItem(
            title: 'HELP US GROW',
            isSelected: false,
            onTap: () {
              menuController.close();
            },
          ),
          MenuListItem(
            title: 'SETTINGS',
            isSelected: false,
            onTap: () {
              menuController.close();
            },
          ),
        ],
      ),
    );
  }

  _buildMenuTitle() {
    return Transform(
        transform: Matrix4.translationValues(-100.0, 0.0, 0.0),
        child: OverflowBox(
          maxWidth: double.infinity,
          alignment: Alignment.topLeft,
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              'Menu',
              style: TextStyle(
                  color: Color(0x88444444),
                  fontSize: 240.0,
                  fontFamily: 'mermaid'),
              textAlign: TextAlign.left,
              softWrap: false,
            ),
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return ZoomScaffoldMenuController(
      builder: (BuildContext context, MenuController menuController) {
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage( 
                  image: AssetImage('assets/grey_bk.jpg'), fit: BoxFit.cover)),
          child: Material(
            color: Colors.transparent,
            child: Stack(
              children: <Widget>[_buildMenuTitle(), _buildMenuItems(menuController)],
            ),
          ),
        );
      },
    );
  }
}

class MenuListItem extends StatelessWidget {
  final String title;
  final bool isSelected;
  final Function onTap;

  MenuListItem({
    this.title, 
    this.isSelected, 
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Color(0x44000000),
      onTap: isSelected ? null : onTap,
      child: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.only(left: 50.0, top: 15.0, bottom: 15.0),
          child: Text(
            title,
            style: TextStyle(
                color: isSelected ? Colors.red : Colors.white,
                fontSize: 25.0,
                letterSpacing: 2.0),
          ),
        ),
      ),
    );
  }
}
