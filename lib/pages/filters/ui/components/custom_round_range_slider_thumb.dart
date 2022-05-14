import 'package:flutter/material.dart';
import 'dart:math' as math;

class CustomRoundRangeSliderThumbShape extends RangeSliderThumbShape {
  const CustomRoundRangeSliderThumbShape({
    this.enabledThumbRadius = 10.0,
    this.disabledThumbRadius,
    this.elevation = 1.0,
    this.pressedElevation = 6.0,
    this.range = const RangeValues(0.0, 0.0),
    required this.min,
    required this.max,
  });

  final double enabledThumbRadius;
  final double? disabledThumbRadius;
  double get _disabledThumbRadius => disabledThumbRadius ?? enabledThumbRadius;
  final double elevation;
  final RangeValues range;
  final double min;
  final double max;
  final double pressedElevation;

  String getValue(double value) {
    return value % 1 != 0 ? value.toString() : value.toInt().toString();
  }

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(
        isEnabled == true ? enabledThumbRadius : _disabledThumbRadius);
  }

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    bool isDiscrete = false,
    bool isEnabled = false,
    bool? isOnTop,
    required SliderThemeData sliderTheme,
    TextDirection? textDirection,
    Thumb? thumb,
    bool? isPressed,
  }) {
    final Canvas canvas = context.canvas;
    final Tween<double> radiusTween = Tween<double>(
      begin: _disabledThumbRadius,
      end: enabledThumbRadius,
    );
    final ColorTween colorTween = ColorTween(
      begin: sliderTheme.disabledThumbColor,
      end: sliderTheme.thumbColor,
    );
    final double radius = radiusTween.evaluate(enableAnimation);
    final Tween<double> elevationTween = Tween<double>(
      begin: elevation,
      end: pressedElevation,
    );

    TextSpan getTextSpan(String value, Color color) => TextSpan(
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: color, //Text Color of Value on Thumb
          ),
          text: value,
        );

    // Add a stroke of 1dp around the circle if this thumb would overlap
    // the other thumb.
    if (isOnTop == true) {
      final Paint strokePaint = Paint()
        ..color = sliderTheme.overlappingShapeStrokeColor!
        ..strokeWidth = 1.0
        ..style = PaintingStyle.stroke;
      canvas.drawCircle(center, radius, strokePaint);
    }

    final Color color = colorTween.evaluate(enableAnimation)!;

    final TextSpan span = getTextSpan(
        getValue(thumb?.index == 0 ? range.start : range.end),
        sliderTheme.thumbColor!);

    TextPainter getTextPainter(TextSpan textSpan) => TextPainter(
          text: textSpan,
          textAlign: TextAlign.center,
          textDirection: TextDirection.ltr,
        );

    final TextSpan startText = getTextSpan(getValue(min), sliderTheme.activeTrackColor!);

    final TextSpan endText = getTextSpan(getValue(max), sliderTheme.activeTrackColor!);

    TextPainter textPainter = getTextPainter(span);
    TextPainter startTextPainter = getTextPainter(startText);
    TextPainter endTextPainter = getTextPainter(endText);

    textPainter.layout();
    startTextPainter.layout();
    endTextPainter.layout();

    // Text Position on Thumb
    Offset textPosition =
        Offset(center.dx - (textPainter.width / 2), center.dy + radius + 10);

    // Text Position on Start Text
    Offset textStartPosition = Offset(-5.5, center.dy + radius + 10);

    // Text Position on End Text
    Offset textEndPosition =
        Offset(context.estimatedBounds.right - 105.5, center.dy + radius + 10);

    final double evaluatedElevation =
        isPressed! ? elevationTween.evaluate(activationAnimation) : elevation;
    final Path shadowPath = Path()
      ..addArc(
          Rect.fromCenter(
              center: center, width: 2 * radius, height: 2 * radius),
          0,
          math.pi * 2);
    canvas.drawShadow(shadowPath, Colors.black, evaluatedElevation, true);

    // Render outer circle
    canvas.drawCircle(
      center,
      radius,
      Paint()..color = Colors.white,
    );

    // Render inner circle
    canvas.drawCircle(
      center,
      radius / 1.4,
      Paint()..color = color,
    );

    // Render value indicator text
    if (thumb!.index == 0) {
      startTextPainter.paint(canvas, textStartPosition);
    } else {
      endTextPainter.paint(canvas, textEndPosition);
    }
    textPainter.paint(canvas, textPosition);
  }
}
