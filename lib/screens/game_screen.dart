import 'package:flutter/material.dart';
import 'dart:async';
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
  Timer? gameTimer;
  final Random random = Random();
  
  // Game data
  late List<List<int>> grid;
  final int gridSize = 6;
  
  // Colors for game pieces
  final List<Color> pieceColors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.yellow,
    Colors.purple,
    Colors.orange,
  ];

  @override
  void initState() {
    super.initState();
    _initGame();
  }

  void _initGame() {
    grid = List.generate(
      gridSize,
      (_) => List.generate(gridSize, (_) => random.nextInt(pieceColors.length)),
    );
    score = 0;
    isPlaying = true;
    setState(() {});
  }

  void _onTileTap(int row, int col) {
    if (!isPlaying) return;
    
    // Check for matches around tapped tile
    _checkAndRemoveMatches(row, col);
    
    setState(() {
      score += 10;
    });
    
    // Check win condition
    if (score >= 100) {
      _showWinDialog();
    }
  }

  void _checkAndRemoveMatches(int row, int col) {
    // Simple match logic - remove tapped tile and regenerate
    grid[row][col] = random.nextInt(pieceColors.length);
  }

  void _showWinDialog() {
    isPlaying = false;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('🎉 فزت!'),
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
  void dispose() {
    gameTimer?.cancel();
    super.dispose();
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
      body: Padding(
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
            return GestureDetector(
              onTap: () => _onTileTap(row, col),
              child: Container(
                decoration: BoxDecoration(
                  color: pieceColors[grid[row][col]],
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: const Offset(2, 2),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
