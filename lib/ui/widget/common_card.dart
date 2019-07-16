import 'package:flutter/material.dart';

class CommonCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets margin;
  final Color color;
  final RoundedRectangleBorder shape;
  final double elevation;

  CommonCard(
      {@required this.child,
      this.margin,
      this.color,
      this.shape,
      this.elevation = 2.0});

  @override
  Widget build(BuildContext context) {
    EdgeInsets margin = this.margin ?? EdgeInsets.all(10);
    Color color = this.color ?? Colors.white;
    RoundedRectangleBorder shape = this.shape ?? RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(5.0)));
    return new Card(
        elevation: elevation,
        shape: shape,
        color: color,
        margin: margin,
        child: child);
  }
}
