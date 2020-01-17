import 'package:flutter/material.dart';

import 'main.dart';

class DotDivider extends StatelessWidget {
  const DotDivider({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).brightness == Brightness.light
        ? lightTheme
        : darkTheme;
    return Padding(
      padding: EdgeInsets.only(left: 4),
      child: Container(
        height: 112,
        child: Column(
          children: <Widget>[
            Spacer(),
            Container(
              height: 6,
              width: 6,
              color: colors[DisplaySetting.text],
            ),
            Container(
              height: 30,
              width: 6,
            ),
            Container(
              height: 6,
              width: 6,
              color: colors[DisplaySetting.text],
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
