import 'package:basketball_timer/model/app_state.dart';
import 'package:basketball_timer/model/player.dart';
import 'package:basketball_timer/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerGrid {
  static Widget forPlayers(BuildContext context, List<Player> players) {
    assert(players != null);
    return _buildGridView(context, players);
  }

  static _buildGridView(BuildContext context, List<Player> players) {
    return GridView.extent(
        maxCrossAxisExtent: 80,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        shrinkWrap: true,
        children: _buildPlayerList(context, players));
  }

  static List<Container> _buildPlayerList(
          BuildContext context, List<Player> players) =>
      List.generate(
          players.length,
          (i) =>
              Container(child: _buildDraggableDragTarget(context, players[i])));

  static Widget _buildDraggableDragTarget(BuildContext context, Player player) {
    return DragTarget<Player>(
      builder: (BuildContext context, List<Player> incoming, List rejected) {
        return _buildPlayerIconDraggable(context, player);
      },
      onWillAccept: (Player data) =>
          player.isOnCourt && !data.isOnCourt ||
          !player.isOnCourt && data.isOnCourt,
      onAccept: (Player data) {
        AppState appState = Provider.of<AppState>(context);
        appState.switchPlayerState(player.name);
        appState.switchPlayerState(data.name);
      },
      onLeave: (data) {},
    );
  }

  static Widget _buildPlayerIconDraggable(BuildContext context, Player player) {
    var _lastTapPosition;
    final RenderBox overlay = Overlay.of(context).context.findRenderObject();
    return Draggable<Player>(
      data: player,
      child: GestureDetector(
          onDoubleTap: () {
            AppState appState = Provider.of<AppState>(context);
            appState.switchPlayerState(player.name);
          },
          onTapDown: (TapDownDetails details) {
            _lastTapPosition = details.globalPosition;
          },
          onLongPress: () {
            showMenu(
              items: <PopupMenuEntry>[
                PopupMenuItem(
                  child: FlatButton(
                    color: Colors.transparent,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Icon(
                            Icons.delete,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(1.0),
                          child: Text(
                            "Löschen",
                            style: TextStyle(),
                          ),
                        ),
                      ],
                    ),
                    onPressed: () {
                      AppState appState = Provider.of<AppState>(context);
                      appState.deletePlayer(player.name);
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
              context: context,
              position: RelativeRect.fromRect(
                  _lastTapPosition & Size(40, 40), Offset.zero & overlay.size),
            );
          },
          child: _buildPlayerIcon(player)),
      feedback: _buildPlayerIcon(player),
      childWhenDragging: Container(),
    );
  }

  static Widget _buildPlayerIcon(Player player) => RawMaterialButton(
        onPressed: () {},
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                player.name,
                style: TextStyles.biggerFont,
              ),
              Text(player.playingTime)
            ]),
        shape: new CircleBorder(),
        constraints: BoxConstraints(minHeight: 60, minWidth: 60),
        elevation: 2.0,
        fillColor: Colors.orange,
        padding: const EdgeInsets.all(2.0),
      );
}
