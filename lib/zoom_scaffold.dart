import 'package:flutter/material.dart';

import './screen.dart';

class ZoomScaffold extends StatefulWidget {
  final Screen contentScreen;
  final Widget menuScreen;

  ZoomScaffold({this.contentScreen, this.menuScreen});

  @override
  _ZoomScaffoldState createState() => _ZoomScaffoldState();
}

class _ZoomScaffoldState extends State<ZoomScaffold> with TickerProviderStateMixin {
  MenuController menuController;
  Curve scaleDownCurve = new Interval(0.0, 0.3, curve: Curves.easeOut);
  Curve scaleUpCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideOutCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);
  Curve slideInCurve = new Interval(0.0, 1.0, curve: Curves.easeOut);

  @override
  void initState() {
    super.initState();
    menuController = MenuController(
      vsync: this
    )..addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    menuController.dispose();
    super.dispose();
  }

  _buildAppBar() {
    return AppBar(
        backgroundColor: Colors
            .transparent, // 1. only setting color to transparent shows the header in grey background, which is nothing but the elevation
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            menuController.toggle();
          },
        ),
        title: Text(
          widget.contentScreen.title,
          style: TextStyle(fontFamily: 'bebas-neue', fontSize: 25.0),
        ));
  }

  _buildContentDisplay() {
    return zoomAndSlideContent(Container(
      decoration: BoxDecoration(image: widget.contentScreen.background),
      child: Scaffold(
          backgroundColor: Colors
              .transparent, // 2. need to make it transparent for vontainer back img to be viisble
          appBar: _buildAppBar(),
          body: widget.contentScreen.contentBuilder(context)),
    ));
  }

  zoomAndSlideContent(Widget content) {
    var slidePercent, scalePercent;
    switch (menuController.state) {
      case MenuState.closed:
        slidePercent = 0.0;
        scalePercent = 0.0;
        break;
      case MenuState.open:
        slidePercent = 1.0;
        scalePercent = 1.0;
        break;
      case MenuState.opening:
        slidePercent = slideOutCurve.transform(menuController.percentOpen);
        scalePercent = scaleDownCurve.transform(menuController.percentOpen);
        break;
      case MenuState.closed: 
        slidePercent = slideInCurve.transform(menuController.percentOpen);
        scalePercent = scaleUpCurve.transform(menuController.percentOpen);
        break;
      default:
  }

    final slideAmount = 275.0 * slidePercent;
    final contentScale = 1.0 - (0.2 * scalePercent);
    final cornerRadius = 10.0 * menuController.percentOpen;

    return Transform(
        transform: Matrix4.translationValues(slideAmount, 0.0, 0.0)
          ..scale(contentScale, contentScale),
        alignment: Alignment.centerLeft,
        child: Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Color(0x44000000),
                offset: Offset(0.0, 0.5),
                blurRadius: 20.0,
                spreadRadius: 0.0)
          ]),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(cornerRadius),
            child: content,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        widget.menuScreen,
        _buildContentDisplay(),
      ],
    );
  }
}

class MenuController extends ChangeNotifier {
  final TickerProvider vsync;
  final AnimationController _animationController;

  MenuState state = MenuState.closed;

  MenuController({
    this.vsync,
  }):_animationController=AnimationController(vsync: vsync) {
    _animationController
    ..duration = Duration(milliseconds: 250)
    ..addListener(() {
      notifyListeners();
    })
    ..addStatusListener((AnimationStatus status){
      switch(status) {
        case AnimationStatus.forward: 
          state =MenuState.opening;
          break;
        case AnimationStatus.reverse: 
          state =MenuState.closing;
          break;
        case AnimationStatus.completed: 
          state =MenuState.open;
          break;
        case AnimationStatus.dismissed: 
          state =MenuState.closed;
          break;
      }
      notifyListeners();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  get percentOpen {
    return _animationController.value;
  }

  open() {
    _animationController.forward();
  }

  close() {
    _animationController.reverse();
  }

  toggle() {
    if (state == MenuState.closed) {
      open();
    } else if (state == MenuState.open) {
      close();
    }
  }
}

enum MenuState { closed, opening, open, closing }

class ZoomScaffoldMenuController extends StatelessWidget {

  final ZoomScaffoldBuilder builder;

  ZoomScaffoldMenuController({
    this.builder
  });

  getMenuController(BuildContext context) {
    final scaffoldState = context.ancestorStateOfType(
      TypeMatcher<_ZoomScaffoldState>()
    ) as _ZoomScaffoldState;
    return scaffoldState.menuController;
  }

  @override
  Widget build(BuildContext context) {
    return builder(context, getMenuController(context));
  }
}


typedef Widget ZoomScaffoldBuilder(
  BuildContext context,
  MenuController menuController
);
