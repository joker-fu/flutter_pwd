import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_pwd/ui/widget/gesture/min_gesture_password.dart';

class MinCirclePainter extends CustomPainter {
  MinCirclePainter(this.itemAttribute, this.circleList, this.selectedStr) {
    List<String> splits = selectedStr.split('');
    for (String index in splits) {
      lineList.add(circleList[int.parse(index)]);
    }
  }

  final List<Circle> circleList;
  List<Circle> lineList = List();
  final MiniItemAttribute itemAttribute;
  final String selectedStr;

  @override
  void paint(Canvas canvas, Size size) {
    //没选中小圆
    final normalCirclePaint = new Paint()
      ..color = itemAttribute.normalColor
      ..style = PaintingStyle.fill;

    //选中小圆
    final selectedCirclePaint = new Paint()
      ..color = itemAttribute.selectedColor
      ..style = PaintingStyle.fill;

    //线
    final linePaint = new Paint()
      ..color = itemAttribute.selectedColor
      ..style = PaintingStyle.fill
      ..strokeWidth = itemAttribute.lineStrokeWidth;

    for (int i = 0; i < circleList.length; i++) {
      Circle circle = circleList[i];
      canvas.drawCircle(
          circle.offset, itemAttribute.smallCircleR, normalCirclePaint);
      if (lineList.contains(circle)) {
        canvas.drawCircle(
            circle.offset, itemAttribute.smallCircleR, selectedCirclePaint);
      }
    }
    if (lineList.length > 0) {
      for (int i = 0; i < lineList.length; i++) {
        canvas.drawLine(
                lineList[i].offset,
                i == (lineList.length - 1) ? lineList[i].offset : lineList[i + 1].offset,
                linePaint);
      }
    }
  }

  @override
  bool shouldRepaint(MinCirclePainter old) => true;
}
