import 'package:flutter/material.dart';
import '../theme/game_theme.dart';

class GameBoard extends StatelessWidget {
  final List<List<int>> grid;
  final Function(int x, int y) onTileTap;

  const GameBoard(this.grid, this.onTileTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: GameTheme.backgroundColor,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: grid.length,
        ),
        itemCount: grid.length * grid.length,
        itemBuilder: (context, index) {
          final x = index % grid.length;
          final y = index ~/ grid.length;
          return GestureDetector(
            onTap: () => onTileTap(x, y),
            child: Container(
              margin: const EdgeInsets.all(2.0),
              color: Colors.primaries[grid[x][y] % Colors.primaries.length],
            ),
          );
        },
      ),
    );
  }
}