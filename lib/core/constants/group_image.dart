import 'package:flutter/material.dart';

class GroupedImages extends StatelessWidget {
  final String topImage;
  final String bottomImage;
  final double spacing;
  final double size;
  final Axis direction; // vertical or horizontal

  const GroupedImages({
    super.key,
    required this.topImage,
    required this.bottomImage,
    this.spacing = 8,
    this.size = 120,
    this.direction = Axis.vertical, // default vertical
  });

  @override
  Widget build(BuildContext context) {
    return Flex(
      direction: direction,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(topImage, width: size, height: size, fit: BoxFit.contain),
        SizedBox(width: direction == Axis.horizontal ? spacing : 0,
            height: direction == Axis.vertical ? spacing : 0),
        Image.asset(bottomImage, width: size, height: size, fit: BoxFit.contain),
      ],
    );
  }
}
