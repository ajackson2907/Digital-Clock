import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:flutter_clock_helper/model.dart';
import 'package:flutter_clock_helper/customizer.dart';

import 'digit.dart';
import 'dot_divider.dart';

enum DisplaySetting {
  background,
  text,
  blockColor,
}

final lightTheme = {
  DisplaySetting.background: Color(0xFFD6D6D6),
  DisplaySetting.text: Colors.black,
  DisplaySetting.blockColor: Color(0xFFCCCCCC),
};

final darkTheme = {
  DisplaySetting.background: Colors.black,
  DisplaySetting.text: Colors.lightGreenAccent,
  DisplaySetting.blockColor: Colors.white12,
};

void main() {
  runApp(ClockCustomizer((ClockModel model) => DigitalClock(model)));
}

class DigitalClock extends StatefulWidget {
  const DigitalClock(this.model);

  final ClockModel model;

  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
  var _temperature = '';
  // var _temperatureRange = '';
  var _condition = '';
  // var _location = '';
  DateTime _dateTime = DateTime.now();
  Timer _timer;

  @override
  void initState() {
    super.initState();
    widget.model.addListener(_updateModel);
    _updateTime();
    _updateModel();
  }

  @override
  void didUpdateWidget(DigitalClock oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.model != oldWidget.model) {
      oldWidget.model.removeListener(_updateModel);
      widget.model.addListener(_updateModel);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    widget.model.removeListener(_updateModel);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bigHour;
    var littleHour;
    var bigMinutes;
    var littleMinutes;
    var bigSeconds;
    var littleSeconds;
    final time = DateFormat(widget.model.is24HourFormat ? 'HHmmss' : 'hhmmss')
        .format(_dateTime);
    final displayDate = DateFormat('EEEE, d MMMM yyyy').format(_dateTime);
    bigHour = int.parse(time[0]);
    littleHour = int.parse(time[1]);
    bigMinutes = int.parse(time[2]);
    littleMinutes = int.parse(time[3]);
    bigSeconds = int.parse(time[4]);
    littleSeconds = int.parse(time[5]);
    final colors = Theme.of(context).brightness == Brightness.light
        ? lightTheme
        : darkTheme;

    final displayArea = Center(
      child: AspectRatio(
        aspectRatio: 5 / 3,
        child: Container(
          color: colors[DisplaySetting.background],
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Spacer(),
                    Digit(number: bigHour),
                    Digit(number: littleHour),
                    DotDivider(),
                    Digit(number: bigMinutes),
                    Digit(number: littleMinutes),
                    DotDivider(),
                    Digit(number: bigSeconds),
                    Digit(number: littleSeconds),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 150),
                                child: Text(
                                  _temperature,
                                  style: TextStyle(
                                    color: colors[DisplaySetting.text],
                                    fontSize: 50,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Spacer(),
                              Padding(
                                padding: EdgeInsets.only(right: 150),
                                child: Container(
                                  child: SvgPicture.asset(
                                    'assets/images/$_condition.svg',
                                    semanticsLabel: '$_condition',
                                    color: colors[DisplaySetting.text],
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: DisplayDate(
                                    displayDate: displayDate,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return Container(
      child: displayArea,
    );
  }

  void _updateTime() {
    setState(() {
      _dateTime = DateTime.now();
      _timer = Timer(
        Duration(seconds: 1) - Duration(milliseconds: _dateTime.millisecond),
        _updateTime,
      );
    });
  }

  void _updateModel() {
    setState(() {
      _temperature = widget.model.temperatureString;
      // _temperatureRange = '(${widget.model.low} - ${widget.model.highString})';
      _condition = widget.model.weatherString;
      // _location = widget.model.location;
    });
  }
}

class DisplayDate extends StatelessWidget {
  const DisplayDate({
    Key key,
    @required this.displayDate,
  }) : super(key: key);

  final String displayDate;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? lightTheme
        : darkTheme;
    return Text(
      displayDate,
      style: TextStyle(
        color: colors[DisplaySetting.text],
        fontSize: 30,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
