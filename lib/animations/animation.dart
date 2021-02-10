import 'package:flutter/material.dart';

class CuadradoAnimado extends StatefulWidget {
  CuadradoAnimado({this.child});
  Widget child;

  @override
  __CuadradoAnimadoState createState() => __CuadradoAnimadoState();
}

class __CuadradoAnimadoState extends State<CuadradoAnimado>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> agrandar;

  @override
  void initState() {
    animationController = new AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    agrandar = Tween<double>(begin: 1.0, end: 1.5).animate(animationController);

    animationController.addListener(() {
      // print('Status: ${animationController.status}');
      if (animationController.status == AnimationStatus.completed) {
        animationController.reverse();
      }
    });

    animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      child: widget.child,
      builder: (BuildContext context, Widget child) {
        return Transform.scale(scale: agrandar.value, child: child);
      },
    );
  }
}
