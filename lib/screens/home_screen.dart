import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _output = "";
  String _currentInput = "";
  String _operator = "";
  double _firstNumber = 0;
  double _secondNumber = 0;

  void _buttonPressed(String buttonText) {
    if (buttonText == "C") {
      _clear();
    } else if (buttonText == "=" || buttonText == "+" || buttonText == "-" || buttonText == "÷" || buttonText == "×") {
      if (_currentInput.isNotEmpty) {
        if (_operator.isEmpty) {
          _firstNumber = double.parse(_currentInput);
          _currentInput = "";
          _operator = buttonText;
        } else {
          _secondNumber = double.parse(_currentInput);
          _calculate();
          _operator = buttonText == "=" ? "" : buttonText;
        }
      }
    } else {
      _currentInput += buttonText;
      _output = _currentInput;
    }

    setState(() {
      // Update state and refresh UI
    });
  }

  void _clear() {
    _currentInput = "";
    _operator = "";
    _output = "";
    _firstNumber = 0;
    _secondNumber = 0;
  }

  void _calculate() {
    switch (_operator) {
      case '+':
        _output = (_firstNumber + _secondNumber).toString();
        break;
      case '-':
        _output = (_firstNumber - _secondNumber).toString();
        break;
      case '×':
        _output = (_firstNumber * _secondNumber).toString();
        break;
      case '÷':
        _output = _secondNumber != 0 ? (_firstNumber / _secondNumber).toString() : "Error";
        break;
    }
    _currentInput = _output;
    _firstNumber = _secondNumber = 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('حاسبة'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
            alignment: Alignment.centerRight,
            child: Text(
              _output,
              style: const TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Divider(),
          _buildButtonRow(["7", "8", "9", "÷"]),
          _buildButtonRow(["4", "5", "6", "×"]),
          _buildButtonRow(["1", "2", "3", "-"])
          ,
          _buildButtonRow(["C", "0", "=", "+"]),
        ],
      ),
    );
  }

  Widget _buildButtonRow(List<String> buttons) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: buttons
          .map((String buttonText) =>
              _buildButton(buttonText, () => _buttonPressed(buttonText)))
          .toList(),
    );
  }

  Widget _buildButton(String buttonText, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.all(20.0),
            textStyle: const TextStyle(fontSize: 20.0),
          ),
          child: Text(buttonText),
        ),
      ),
    );
  }
}
