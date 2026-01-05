import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';
import '../game/game_board.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final int _gridSize = 8;
  int _score = 0;
  bool _isPlaying = true;
  late List<List<int>> _grid;
  final Random _random = Random();
  Timer? _gameTimer;

  @override
  void initState() {
    super.initState();
    _startGame();
  }

  void _startGame() {
    _initializeGrid();
    _gameTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (_isPlaying) {
        _updateGame();
      }
    });
  }

  void _initializeGrid() {
    _grid = List.generate(_gridSize,
        (x) => List.generate(_gridSize, (y) => _random.nextInt(5)));
    setState(() {});
  }

  void _updateGame() {
    // Placeholder for future game logic
    setState(() {});
  }

  void _onTileTap(int x, int y) {
    // Placeholder logic for swapping
    setState(() {
      _score++;
    });
    if (_score > 50) {
      _gameOver();
    }
  }

  void _gameOver() {
    _gameTimer?.cancel();
    setState(() {
      _isPlaying = false;
    });
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Game Over!'),
        content: Text('Your score is $_score'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _startGame();
            },
            child: const Text('Play Again'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _gameTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Score: $_score'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _startGame,
          ),
        ],
      ),
      body: GameBoard(_grid, _onTileTap),
    );
  }
}