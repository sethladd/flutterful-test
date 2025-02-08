import 'package:flutter/material.dart';

enum ColorSpace {
  hsv,
  rgb,
}

class ColorState {
  // HSV values
  final double hue;
  final double saturation;
  final double value;

  // RGB values
  final int red;
  final int green;
  final int blue;

  // Shared
  final double opacity;
  final ColorSpace colorSpace;

  const ColorState({
    this.hue = 0.0,
    this.saturation = 1.0,
    this.value = 1.0,
    this.red = 255,
    this.green = 0,
    this.blue = 0,
    this.opacity = 1.0,
    this.colorSpace = ColorSpace.hsv,
  });

  Color toColor() {
    if (colorSpace == ColorSpace.hsv) {
      return HSVColor.fromAHSV(opacity, hue, saturation, value).toColor();
    } else {
      return Color.fromRGBO(red, green, blue, opacity);
    }
  }

  String toCode() {
    if (colorSpace == ColorSpace.hsv) {
      return '''HSVColor.fromAHSV(
  ${opacity.toStringAsFixed(2)},
  ${hue.toStringAsFixed(1)},
  ${saturation.toStringAsFixed(2)},
  ${value.toStringAsFixed(2)},
).toColor()''';
    } else {
      return '''Color.fromRGBO(
  $red,
  $green,
  $blue,
  ${opacity.toStringAsFixed(2)},
)''';
    }
  }

  ColorState copyWith({
    double? hue,
    double? saturation,
    double? value,
    int? red,
    int? green,
    int? blue,
    double? opacity,
    ColorSpace? colorSpace,
  }) {
    return ColorState(
      hue: hue ?? this.hue,
      saturation: saturation ?? this.saturation,
      value: value ?? this.value,
      red: red ?? this.red,
      green: green ?? this.green,
      blue: blue ?? this.blue,
      opacity: opacity ?? this.opacity,
      colorSpace: colorSpace ?? this.colorSpace,
    );
  }
}
