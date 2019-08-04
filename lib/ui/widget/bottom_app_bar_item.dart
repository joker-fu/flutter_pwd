import 'package:flutter/material.dart';
import 'package:flutter_pwd/res/dimens.dart';

class BottomAppBarItem extends StatefulWidget {
  final IconData icon;
  final String name;
  final Color selectedColor;
  final Color unselectedColor;
  final bool selected;
  final VoidCallback onTap;

  BottomAppBarItem(
      {@required this.icon,
      @required this.name,
      @required this.selectedColor,
      @required this.unselectedColor,
      @required this.selected,
      @required this.onTap});

  @override
  _BottomAppBarItemState createState() => _BottomAppBarItemState();
}

class _BottomAppBarItemState extends State<BottomAppBarItem> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _tap(),
      onDoubleTap: () => _tap(),
      child: Container(
        height: Dimens.dp56,
        width: Dimens.dp100,
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                widget.icon,
                color: widget.selected
                    ? widget.selectedColor
                    : widget.unselectedColor,
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: Dimens.sp14,
                  color: widget.selected
                      ? widget.selectedColor
                      : widget.unselectedColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _tap() {
    widget.onTap();
    setState(() {});
  }
}
