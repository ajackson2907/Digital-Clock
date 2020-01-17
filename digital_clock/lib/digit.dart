import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'main.dart';

class Digit extends StatelessWidget {
  final number;

  Digit({this.number});

  @override
  Widget build(BuildContext context) {
    Map<String, bool> _pattern = _fetchPattern(number);
    final colors = Theme.of(context).brightness == Brightness.light
        ? lightTheme
        : darkTheme;
    return Padding(
      padding:
          const EdgeInsets.only(top: 8.0, bottom: 8.0, left: 12.0, right: 6.0),
      child: Container(
        height: 112,
        width: 60,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 0,
              left: 5,
              child: SvgPicture.asset(
                'assets/images/block.svg',
                semanticsLabel: 'top center',
                color: _pattern["top"]
                    ? colors[DisplaySetting.text]
                    : colors[DisplaySetting.blockColor],
              ),
            ),
            Positioned(
              top: 104,
              left: 5,
              child: SvgPicture.asset(
                'assets/images/block.svg',
                semanticsLabel: 'bottom center',
                color: _pattern["bottom"]
                    ? colors[DisplaySetting.text]
                    : colors[DisplaySetting.blockColor],
              ),
            ),
            Positioned(
              top: 52,
              left: 5,
              child: SvgPicture.asset(
                'assets/images/block.svg',
                semanticsLabel: 'center',
                color: _pattern["middle"]
                    ? colors[DisplaySetting.text]
                    : colors[DisplaySetting.blockColor],
              ),
            ),
            Positioned(
              top: 26,
              left: -21,
              child: Transform.rotate(
                angle: pi / 2,
                child: SvgPicture.asset(
                  'assets/images/block.svg',
                  semanticsLabel: 'top left',
                  color: _pattern["topLeft"]
                      ? colors[DisplaySetting.text]
                      : colors[DisplaySetting.blockColor],
                ),
              ),
            ),
            Positioned(
              top: 26,
              left: 31,
              child: Transform.rotate(
                angle: pi / 2,
                child: SvgPicture.asset(
                  'assets/images/block.svg',
                  semanticsLabel: 'top right',
                  color: _pattern["topRight"]
                      ? colors[DisplaySetting.text]
                      : colors[DisplaySetting.blockColor],
                ),
              ),
            ),
            Positioned(
              top: 78,
              left: -21,
              child: Transform.rotate(
                angle: pi / 2,
                child: SvgPicture.asset(
                  'assets/images/block.svg',
                  semanticsLabel: 'bottom left',
                  color: _pattern["bottomLeft"]
                      ? colors[DisplaySetting.text]
                      : colors[DisplaySetting.blockColor],
                ),
              ),
            ),
            Positioned(
              top: 78,
              left: 31,
              child: Transform.rotate(
                angle: pi / 2,
                child: SvgPicture.asset(
                  'assets/images/block.svg',
                  semanticsLabel: 'bottom right',
                  color: _pattern["bottomRight"]
                      ? colors[DisplaySetting.text]
                      : colors[DisplaySetting.blockColor],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, bool> _fetchPattern(int number) {
    switch (number) {
      case 0:
        return DigitPattern().zero;
        break;
      case 1:
        return DigitPattern().one;
        break;
      case 2:
        return DigitPattern().two;
        break;
      case 3:
        return DigitPattern().three;
        break;
      case 4:
        return DigitPattern().four;
        break;
      case 5:
        return DigitPattern().five;
        break;
      case 6:
        return DigitPattern().six;
        break;
      case 7:
        return DigitPattern().seven;
        break;
      case 8:
        return DigitPattern().eight;
        break;
      case 9:
        return DigitPattern().nine;
        break;
      default:
        return DigitPattern().blank;
    }
  }
}

class DigitPattern {
  final blank = {
    "top": true,
    "middle": true,
    "bottom": true,
    "topRight": true,
    "topLeft": true,
    "bottomRight": true,
    "bottomLeft": true,
  };

  final zero = {
    "top": true,
    "middle": false,
    "bottom": true,
    "topRight": true,
    "topLeft": true,
    "bottomRight": true,
    "bottomLeft": true,
  };

  final one = {
    "top": false,
    "middle": false,
    "bottom": false,
    "topRight": true,
    "topLeft": false,
    "bottomRight": true,
    "bottomLeft": false,
  };

  final two = {
    "top": true,
    "middle": true,
    "bottom": true,
    "topRight": true,
    "topLeft": false,
    "bottomRight": false,
    "bottomLeft": true,
  };

  final three = {
    "top": true,
    "middle": true,
    "bottom": true,
    "topRight": true,
    "topLeft": false,
    "bottomRight": true,
    "bottomLeft": false,
  };

  final four = {
    "top": false,
    "middle": true,
    "bottom": false,
    "topRight": true,
    "topLeft": true,
    "bottomRight": true,
    "bottomLeft": false,
  };

  final five = {
    "top": true,
    "middle": true,
    "bottom": true,
    "topRight": false,
    "topLeft": true,
    "bottomRight": true,
    "bottomLeft": false,
  };

  final six = {
    "top": true,
    "middle": true,
    "bottom": true,
    "topRight": false,
    "topLeft": true,
    "bottomRight": true,
    "bottomLeft": true,
  };

  final seven = {
    "top": true,
    "middle": false,
    "bottom": false,
    "topRight": true,
    "topLeft": false,
    "bottomRight": true,
    "bottomLeft": false,
  };

  final eight = {
    "top": true,
    "middle": true,
    "bottom": true,
    "topRight": true,
    "topLeft": true,
    "bottomRight": true,
    "bottomLeft": true,
  };

  final nine = {
    "top": true,
    "middle": true,
    "bottom": true,
    "topRight": true,
    "topLeft": true,
    "bottomRight": true,
    "bottomLeft": false,
  };
}
