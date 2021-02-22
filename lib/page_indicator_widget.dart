import 'package:flutter/material.dart';

class PageIndicatorWidget extends StatelessWidget {
  const PageIndicatorWidget({
    Key key,
    @required this.count,
    @required this.value,
    this.size = 8,
    this.spacing = 16,
  }) : super(key: key);

  final int count;
  final int value;
  final double size;
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        for (int i = 0; i < count; i++)
          AnimatedContainer(
            height: size,
            width: size,
            margin: EdgeInsets.fromLTRB(
              0,
              spacing,
              i == count - 1 ? 0 : spacing,
              spacing,
            ),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: i == value ? Color(0xFF3A953C) : Colors.white,
            ),
            duration: Duration(milliseconds: 900),
          )
      ],
    );
  }
}
