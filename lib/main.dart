import 'package:basketball_timer/model/player.dart';
import 'package:basketball_timer/textstyles.dart';
import 'package:basketball_timer/widgets/active_player_grid.dart';
import 'package:basketball_timer/widgets/game_clock.dart';
import 'package:basketball_timer/widgets/inactive_player_grid.dart';
import 'package:basketball_timer/widgets/input_modal.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import 'model/app_state.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => AppState()),
        ],
        child: MaterialApp(
          title: 'Basketball Timer',
          theme: ThemeData(
            primarySwatch: Colors.orange,
          ),
          home: TimerPage(title: 'Spielzeit'),
        ));
  }
}

class TimerPage extends StatefulWidget {
  TimerPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> {
  @override
  Widget build(BuildContext context) {
    AppState appState = Provider.of<AppState>(context);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title), actions: <Widget>[
        // action button
        IconButton(
          icon: Icon(Icons.delete),
          onPressed: () {
            appState.reset();
          },
        ),
      ]),
      body:
//      Center(
//        child:
        Observer(builder: (_) {
          //just retrieving the value to trigger update of the screen
          //note that it has to be assigned to a variable, otherwise the
          //clock doesn't update itself :-(
          var updateScreenTicker = appState
              .updateScreenTicker;
          return SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Text(
                'Auf dem Spielfeld:',
                style: TextStyles.headLine,
              ),
              _halfCourtDragArea(),
              Text(
                'Auswechselspieler:',
                style: TextStyles.headLine,
              ),
              if (appState.playersOffCourt.isEmpty && appState.playersOnCourt.isEmpty)
                Text("Spieler über das '+' hinzufügen"),
              _substituteDragArea(),
              Text(
                'Spielzeit:',
                style: TextStyles.headLine,
              ),
              GameClock(),
            ],
          ));
        }),
//      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          InputModal.displayDialog(
            context,
            title: "Spieler hinzufügen",
            hintText: "Jordy Michaels",
            onSuccess: (playerName) => appState.addPlayer(playerName),
          );
        },
        tooltip: 'Spieler hinzufügen',
        child: Icon(Icons.person_add),
        backgroundColor: Colors.orangeAccent,
        elevation: 10, //add a bit more elevation to distinguish it more from the orange blips of the players
      ),
    );
  }

  Widget _halfCourtDragArea() {
    return DragTarget<Player>(
      builder: (BuildContext context, List<Player> incoming, List rejected) {
        return Container(
          constraints: BoxConstraints(minHeight: 200.0),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/halfcourt.png"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              ActivePlayerGrid(),
            ],
          ),
        );
      },
      onWillAccept: (Player data) => !data.isOnCourt,
      onAccept: (data) {
        setState(() {
          data.isOnCourt = !data.isOnCourt;
        });
      },
      onLeave: (data) {},
    );
  }

  Widget _substituteDragArea() {
    return DragTarget<Player>(
      builder: (BuildContext context, List<Player> incoming, List rejected) {
        return DottedBorder(
          color: Colors.grey,
          strokeWidth: 1,
          child: Container(
            constraints: BoxConstraints(minHeight: 220.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                InactivePlayerGrid(),
              ],
            ),
          ),
        );
      },
      onWillAccept: (Player data) => data.isOnCourt,
      onAccept: (data) {
        setState(() {
          data.isOnCourt = !data.isOnCourt;
        });
      },
      onLeave: (data) {},
    );
  }
}
