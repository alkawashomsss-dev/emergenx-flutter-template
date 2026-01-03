import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _output = '0';
  String _input = '';

  void _inputDigit(String digit) {
    setState(() {
      if (_input.isEmpty && digit == '0') {
        return;
      }
      _input += digit;
      _output = _input;
    });
  }

  void _clear() {
    setState(() {
      _input = '';
      _output = '0';
    });
  }

  void _calculate() {
    try {
      final result = _evaluateExpression(_input);
      setState(() {
        _output = result.toString();
      });
    } catch (e) {
      setState(() {
        _output = 'خطأ';
      });
    }
  }

  num _evaluateExpression(String expression) {
    // لاحظ أنه حل بسيط وغير آمن للتعليم فقط
    return double.parse(expression);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الحاسبة البسيطة')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(24),
              alignment: Alignment.bottomRight,
              child: Text(
                _output,
                style: Theme.of(context).textTheme.headlineLarge,
              ),
            ),
          ),
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildButtonRow(['7', '8', '9']),
                  _buildButtonRow(['4', '5', '6']),
                  _buildButtonRow(['1', '2', '3']),
                  _buildButtonRow(['0', 'C', '=']),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> symbols) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: symbols.map((symbol) => _buildButton(symbol)).toList(),
    );
  }

  Widget _buildButton(String symbol) {
    return ElevatedButton(
      onPressed: () {
        if (symbol == 'C') {
          _clear();
        } else if (symbol == '=') {
          _calculate();
        } else {
          _inputDigit(symbol);
        }
      },
      child: Text(symbol),
    );
  }
}
