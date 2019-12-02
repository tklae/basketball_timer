import 'package:basketball_timer/model/app_state.dart';
import 'package:basketball_timer/model/player.dart';
import 'package:basketball_timer/textstyles.dart';
import 'package:basketball_timer/widgets/player_grid.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

class InactivePlayerGrid extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);
    return Observer(
        builder: (_) =>PlayerGrid.forPlayers(context, appState.playersOffCourt)
    );
  }
}
