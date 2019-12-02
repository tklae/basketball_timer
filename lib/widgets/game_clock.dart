import 'package:basketball_timer/model/app_state.dart';
import 'package:basketball_timer/utils/string_formatter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../textstyles.dart';
import 'blinking_widget.dart';

class GameClock extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);

    return Observer(
        builder: (_) => RawMaterialButton(
              onPressed: () {
                appState.gameTime.isRunning
                    ? appState.stopClock()
                    : appState.startClock();
              },
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    appState.gameTime.isRunning
                        ? BlinkWidget(
                            children: <Widget>[
                              Text(
                                  StringFormatter.durationInMinutesAndSeconds(
                                      appState.gameTime.elapsed),
                                  style: TextStyles.biggerFont)
                            ],
                          )
                        : Text(
                            StringFormatter.durationInMinutesAndSeconds(
                                appState.gameTime.elapsed),
                            style: TextStyles.biggerFont),
                    Text(
                        "Zum ${appState.gameTime.isRunning ? "Stoppen" : "Starten"} klicken")
                  ]),
              shape: new RoundedRectangleBorder(borderRadius:  BorderRadius.circular(10)),
              constraints: BoxConstraints(minHeight: 80, minWidth: 150),
              elevation: 2.0,
              fillColor: appState.gameTime.isRunning ? Colors.red : Colors.green,
              padding: const EdgeInsets.all(2.0),
            ));
  }
}
