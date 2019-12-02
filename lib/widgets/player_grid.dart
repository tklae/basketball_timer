import 'package:basketball_timer/model/player.dart';
import 'package:basketball_timer/textstyles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlayerGrid {
  static Widget forPlayers(BuildContext context, List<Player> players) {
    assert(players != null);
    return _buildGridView(players);
  }

  static _buildGridView(List<Player> players) {
    return GridView.extent(
        maxCrossAxisExtent: 80,
        padding: const EdgeInsets.all(4),
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        shrinkWrap: true,
        children: _buildPlayerList(players));
  }

  static List<Container> _buildPlayerList(List<Player> players) =>
      List.generate(players.length,
          (i) => Container(child: _buildDraggableDragTarget(players[i])));

  static Widget _buildDraggableDragTarget(Player player) {
    return DragTarget<Player>(
      builder: (BuildContext context, List<Player> incoming, List rejected) {
        return _buildPlayerIconDraggable(player);
      },
      onWillAccept: (Player data) =>
          player.isOnCourt && !data.isOnCourt ||
          !player.isOnCourt && data.isOnCourt,
      onAccept: (data) {
        player.isOnCourt = !player.isOnCourt;
        data.isOnCourt = !data.isOnCourt;
      },
      onLeave: (data) {},
    );
  }

  static Widget _buildPlayerIconDraggable(Player player) => Draggable<Player>(
        data: player,
        child: _buildPlayerIcon(player),
        feedback: _buildPlayerIcon(player),
        childWhenDragging: Container(),
      );

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
