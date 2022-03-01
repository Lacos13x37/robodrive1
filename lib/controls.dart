import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:robodrive/game_state.dart';


class Controls extends StatelessWidget {
  const Controls({ Key? key }) : super(key: key);

Widget _emptyCell() {
  return Container();
}

Widget _buttonCell(Direction dir, GameState state) {
  return GestureDetector(
    child: Container(
      child: Transform.rotate(
        angle: getRotationAngle(dir),
        child: const Icon(
        Icons.play_arrow_rounded,
        color: Colors.white,
        size: 36,
      ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: Colors.black54,
      ),
    ),
    onTap: () {
        if (dir != state.opposite(state.currentDir))
        state.nextDir = dir;
    },
  );
}

  @override
  Widget build(BuildContext context) {

    final state = Provider.of<GameState>(context);

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        child: AspectRatio(
          aspectRatio: 1,
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 3,
            children: [
              _emptyCell(),
              _buttonCell(Direction.UP, state),
              _emptyCell(),
              _buttonCell(Direction.LEFT, state),
              _emptyCell(),
              _buttonCell(Direction.RIGHT, state),
              _emptyCell(),
              _buttonCell(Direction.DOWN, state),
              _emptyCell(),
            ],
          ),
      ),
      ),
    );
  }
}