import 'package:flutter/material.dart';
import 'package:simple_snowfall/enums/startposition_enum.dart';

import 'snow_painter.dart';

class SnowfallWidget extends StatefulWidget {
  final int numberOfSnowflakes;
  final double windIntensity;
  final double gravity;
  final Size? size; // Added size parameter

  const SnowfallWidget({
    Key? key,
    this.numberOfSnowflakes = 100,
    this.windIntensity = 0.1,
    this.gravity = 0.1,
    this.size, // Accepts size parameter
  }) : super(key: key);

  @override
  State<SnowfallWidget> createState() => _SnowfallWidgetState();
}

class _SnowfallWidgetState extends State<SnowfallWidget>
    with SingleTickerProviderStateMixin {
  late List<SnowFlake> snowflakes;
  late AnimationController _controller;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    )..repeat();

    snowflakes = List.generate(
      widget.numberOfSnowflakes,
      (index) => SnowFlake(
        startPosition: SnowfallStartPosition.random,
        size: widget.size ??
            Size(
              MediaQuery.of(context).size.width,
              MediaQuery.of(context).size.height,
            ),
        gravity: widget.gravity,
        windX: 0,
        windY: 0,
      ),
    );

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final givenSize = widget.size ?? screenSize;

    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        for (var snow in snowflakes) {
          snow.fall(
            snowfallRegion: Rect.fromLTRB(
              0,
              0,
              givenSize.width,
              givenSize.height,
            ),
          );
        }

        return CustomPaint(
          size: widget.size ?? screenSize,
          painter: SnowPainter(snowflakes),
        );
      },
    );
  }
}
