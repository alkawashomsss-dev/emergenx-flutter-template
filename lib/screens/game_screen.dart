import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static const int gridSize = 4;
  List<List<int?>> grid = List.generate(gridSize, (_) => List.filled(gridSize, null));
  int score = 0;
  bool isGameOver = false;
  final Random random = Random();

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  void _initializeGame() {
    grid = List.generate(gridSize, (_) => List.filled(gridSize, null));
    score = 0;
    isGameOver = false;
    _addNewTile();
    _addNewTile();
    setState(() {});
  }

  void _addNewTile() {
    List<Point<int>> emptyTiles = [];
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (grid[r][c] == null) {
          emptyTiles.add(Point(r, c));
        }
      }
    }
    if (emptyTiles.isNotEmpty) {
      final randomTile = emptyTiles[random.nextInt(emptyTiles.length)];
      grid[randomTile.x][randomTile.y] = random.nextBool() ? 2 : 4;
    }
  }

  void _moveAndMerge(String direction) {
    setState(() {
      if (direction == 'up') {
        for (int col = 0; col < gridSize; col++) {
          _processColumn(col, ascending: true);
        }
      } else if (direction == 'down') {
        for (int col = 0; col < gridSize; col++) {
          _processColumn(col, ascending: false);
        }
      } else if (direction == 'left') {
        for (int row = 0; row < gridSize; row++) {
          _processRow(row, ascending: true);
        }
      } else if (direction == 'right') {
        for (int row = 0; row < gridSize; row++) {
          _processRow(row, ascending: false);
        }
      }
      _addNewTile();
      _checkGameOver();
    });
  }

  void _processColumn(int col, {bool ascending = true}) {
    List<int> newColumn = grid.map((row) => row[col]).where((val) => val != null).cast<int>().toList();
    if (!ascending) newColumn = newColumn.reversed.toList();
    for (int i = 0; i < newColumn.length - 1; i++) {
      if (newColumn[i] == newColumn[i + 1]) {
        newColumn[i] *= 2;
        score += newColumn[i];
        newColumn.removeAt(i + 1);
      }
    }
    while (newColumn.length < gridSize) {
      if (ascending) {
        newColumn.add(null);
      } else {
        newColumn.insert(0, null);
      }
    }
    if (!ascending) newColumn = newColumn.reversed.toList();
    for (int r = 0; r < gridSize; r++) {
      grid[r][col] = newColumn[r];
    }
  }

  void _processRow(int row, {bool ascending = true}) {
    List<int> newRow = grid[row].where((val) => val != null).cast<int>().toList();
    if (!ascending) newRow = newRow.reversed.toList();
    for (int i = 0; i < newRow.length - 1; i++) {
      if (newRow[i] == newRow[i + 1]) {
        newRow[i] *= 2;
        score += newRow[i];
        newRow.removeAt(i + 1);
      }
    }
    while (newRow.length < gridSize) {
      if (ascending) {
        newRow.add(null);
      } else {
        newRow.insert(0, null);
      }
    }
    if (!ascending) newRow = newRow.reversed.toList();
    grid[row] = newRow;
  }

  void _checkGameOver() {
    // Check if there are any open slots
    for (int r = 0; r < gridSize; r++) {
      for (int c = 0; c < gridSize; c++) {
        if (grid[r][c] == null) return;
        if (r < gridSize - 1 && grid[r][c] == grid[r + 1][c]) return;
        if (c < gridSize - 1 && grid[r][c] == grid[r][c + 1]) return;
      }
    }
    isGameOver = true;
    Future.delayed(Duration.zero, () => _showGameOverDialog());
  }

  void _showGameOverDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('انتهت اللعبة!'),
        content: Text('نقاطك: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('القائمة'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _initializeGame();
            },
            child: const Text('اللعب مرة أخرى'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('النقاط: $score'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _initializeGame,
          ),
        ],
      ),
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! < 0) {
              _moveAndMerge('up');
            } else if (details.primaryVelocity! > 0) {
              _moveAndMerge('down');
            }
          }
        },
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null) {
            if (details.primaryVelocity! < 0) {
              _moveAndMerge('left');
            } else if (details.primaryVelocity! > 0) {
              _moveAndMerge('right');
            }
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: gridSize * gridSize,
            itemBuilder: (context, index) {
              final row = index ~/ gridSize;
              final col = index % gridSize;
              return Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: grid[row][col] == null ? Colors.grey.shade300 : Colors.teal.shade700,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  grid[row][col]?.toString() ?? '',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
