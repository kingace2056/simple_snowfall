import 'dart:math';
import 'package:flutter/material.dart';
import 'package:snowfall/enums/startposition_enum.dart';

class SnowPainter extends CustomPainter {
  final List<SnowFlake> snowflakes;

  SnowPainter(this.snowflakes);

  @override
  void paint(Canvas canvas, Size size) {
    final whitePaint = Paint()..color = Colors.white;
    for (var snow in snowflakes) {
      canvas.drawCircle(Offset(snow.x, snow.y), snow.radius, whitePaint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class SnowFlake {
  double x;
  double y;
  double radius = Random().nextDouble() * 2 + 2;
  double speed = 1.0;
  double direction = Random().nextDouble() * 2 * pi;
  final double gravity;
  final double windX;
  final double windY;
  final Size size;
  final SnowfallStartPosition startPosition;

  SnowFlake({
    required this.gravity,
    required this.windX,
    required this.windY,
    required this.size,
    this.startPosition = SnowfallStartPosition.random,
  })  : x = _calculateXPosition(startPosition, size),
        y = _calculateYPosition(startPosition, size);

  static double _calculateXPosition(
    SnowfallStartPosition startPosition,
    Size? size,
  ) {
    switch (startPosition) {
      case SnowfallStartPosition.left:
        return 0.0;
      case SnowfallStartPosition.right:
        return size?.width ?? 0.0;
      case SnowfallStartPosition.top:
      case SnowfallStartPosition.bottom:
      case SnowfallStartPosition.center:
        return (size?.width ?? 0.0) / 2;
      case SnowfallStartPosition.random:
        return Random().nextDouble() * (size?.width ?? 0.0);
      default:
        return 0.0;
    }
  }

  static double _calculateYPosition(
    SnowfallStartPosition startPosition,
    Size? size,
  ) {
    switch (startPosition) {
      case SnowfallStartPosition.top:
        return 0.0;
      case SnowfallStartPosition.bottom:
        return size?.height ?? 0.0;
      case SnowfallStartPosition.left:
      case SnowfallStartPosition.right:
      case SnowfallStartPosition.center:
        return (size?.height ?? 0.0) / 2;
      case SnowfallStartPosition.random:
        return Random().nextDouble() * (size?.height ?? 0.0);
      default:
        return 0.0;
    }
  }

  fall({Rect? snowfallRegion}) {
    x += cos(direction) * speed;
    y += sin(direction) * speed;
    speed += (Random().nextDouble() - 0.5) * 0.1;
    direction += (Random().nextDouble() - 0.5) * 0.2;
    x += windX;
    y += windY;

    if (snowfallRegion != null) {
      if (y > snowfallRegion.bottom || y < snowfallRegion.top) {
        x = snowfallRegion.left + snowfallRegion.width / 2;
        y = snowfallRegion.top + snowfallRegion.height / 2;
        radius = Random().nextDouble() * 2 + 2;
        speed = 1.0;
        direction = Random().nextDouble() * 2 * pi;
      }
    } else {
      if (y > 800 || y < 0) {
        x = 400 / 2;
        y = 800 / 2;
        radius = Random().nextDouble() * 2 + 2;
        speed = 1.0;
        direction = Random().nextDouble() * 2 * pi;
      }
    }
  }
}
