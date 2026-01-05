import 'package:flutter/material.dart';
import 'dart:math';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  // Game state
  int score = 0;
  bool isPlaying = true;
  List<List<int>> grid = [];
  final int gridSize = 4;

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    grid = List.generate(gridSize, (_) => List.generate(gridSize, (_) => 0));
    _addNewNumber();
    _addNewNumber();
    score = 0;
    isPlaying = true;
    setState(() {});
  }

  void _addNewNumber() {
    List<Offset> emptyCells = [];
    for (var row = 0; row < gridSize; row++) {
      for (var col = 0; col < gridSize; col++) {
        if (grid[row][col] == 0) {
          emptyCells.add(Offset(row.toDouble(), col.toDouble()));
        }
      }
    }
    if (emptyCells.isNotEmpty) {
      final random = Random();
      final newCell = emptyCells[random.nextInt(emptyCells.length)];
      grid[newCell.dx.toInt()][newCell.dy.toInt()] = random.nextBool() ? 2 : 4;
    }
  }

  void _move(String direction) {
    setState(() {
      if (direction == 'up') {
        _moveUp();
      } else if (direction == 'down') {
        _moveDown();
      } else if (direction == 'left') {
        _moveLeft();
      } else if (direction == 'right') {
        _moveRight();
      }
      _addNewNumber();
      if (_isGameOver()) {
        _showGameOverDialog();
      }
    });
  }

  void _moveLeft() {
    for (var row = 0; row < gridSize; row++) {
      List<int> currentRow = grid[row];
      _mergeRow(currentRow);
      grid[row] = currentRow;
    }
  }

  void _moveRight() {
    for (var row = 0; row < gridSize; row++) {
      List<int> currentRow = List.from(grid[row].reversed);
      _mergeRow(currentRow);
      grid[row] = List.from(currentRow.reversed);
    }
  }

  void _moveUp() {
    for (var col = 0; col < gridSize; col++) {
      List<int> currentColumn = [grid[0][col], grid[1][col], grid[2][col], grid[3][col]];
      _mergeRow(currentColumn);
      for (var row = 0; row < gridSize; row++) {
        grid[row][col] = currentColumn[row];
      }
    }
  }

  void _moveDown() {
    for (var col = 0; col < gridSize; col++) {
      List<int> currentColumn = [grid[3][col], grid[2][col], grid[1][col], grid[0][col]];
      _mergeRow(currentColumn);
      for (var row = 0; row < gridSize; row++) {
        grid[3 - row][col] = currentColumn[row];
      }
    }
  }

  void _mergeRow(List<int> row) {
    for (var i = 0; i < gridSize - 1; i++) {
      if (row[i] == row[i + 1] && row[i] != 0) {
        row[i] *= 2;
        row[i + 1] = 0;
        score += row[i];
      }
    }
    row.removeWhere((tile) => tile == 0);
    while (row.length < gridSize) {
      row.add(0);
    }
  }

  bool _isGameOver() {
    for (var row = 0; row < gridSize; row++) {
      for (var col = 0; col < gridSize; col++) {
        if (grid[row][col] == 0) return false;
        if (col < gridSize - 1 && grid[row][col] == grid[row][col + 1]) return false;
        if (row < gridSize - 1 && grid[row][col] == grid[row + 1][col]) return false;
      }
    }
    return true;
  }

  void _showGameOverDialog() {
    isPlaying = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('👾 انتهت اللعبة!'),
        content: Text('نقاطك: $score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _initGame();
            },
            child: const Text('العب مرة أخرى'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('القائمة'),
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
            onPressed: _initGame,
          ),
        ],
      ),
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy > 0) {
            _move('down');
          } else if (details.velocity.pixelsPerSecond.dy < 0) {
            _move('up');
          }
        },
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            _move('right');
          } else if (details.velocity.pixelsPerSecond.dx < 0) {
            _move('left');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              crossAxisSpacing: 4,
              mainAxisSpacing: 4,
            ),
            itemCount: gridSize * gridSize,
            itemBuilder: (context, index) {
              final row = index ~/ gridSize;
              final col = index % gridSize;
              return Container(
                decoration: BoxDecoration(
                  color: _getColorForValue(grid[row][col]),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Text(
                    grid[row][col] > 0 ? grid[row][col].toString() : '',
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Color _getColorForValue(int value) {
    switch (value) {
      case 2:
        return Colors.grey.shade100;
      case 4:
        return Colors.grey.shade300;
      case 8:
        return Colors.orange.shade400;
      case 16:
        return Colors.orange.shade600;
      case 32:
        return Colors.orange.shade800;
      case 64:
        return Colors.deepOrange;
      default:
        return Colors.brown;
    }
  }
}
