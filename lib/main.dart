import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: CalculatorScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String output = "0";
  String _output = "0";
  double num1 = 0;
  double num2 = 0;
  String operand = '';

  buttonPressed(String buttonText) {
    if (buttonText == 'C') {
      _output = "0";
      num1 = 0;
      num2 = 0;
      operand = '';
    } else if (buttonText == "+" ||
        buttonText == "-" ||
        buttonText == "*" ||
        buttonText == "/") {
      num1 = double.parse(output);
      operand = buttonText;
      _output = "0";
    } else if (buttonText == "=") {
      num2 = double.parse(output);
      switch (operand) {
        case '+':
          _output = (num1 + num2).toString();
          break;
        case '-':
          _output = (num1 - num2).toString();
          break;
        case '*':
          _output = (num1 * num2).toString();
          break;
        case '/':
          _output = (num1 / num2).toString();
          break;
      }
      num1 = 0;
      num2 = 0;
      operand = '';
    } else if (buttonText == '.') {
      if (!_output.contains('.')) {
        _output += buttonText;
      }
    } else {
      if (_output == "0") {
        _output = buttonText;
      } else {
        _output += buttonText;
      }
    }
    setState(() {
      output = double.parse(
        _output,
      ).toStringAsFixed(7).replaceAll(RegExp(r'\.?0+$'), '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: const Text("Calculator", style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.grey[800],
      ),
      body: Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 12),
            child: Text(
              output,
              style: TextStyle(
                fontSize: output.length > 10 ? 30 : 48,
                color: Colors.white,
              ),
            ),
          ),
          Expanded(child: Divider(color: Colors.grey)),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                children: [
                  buildButton("7", Colors.grey),
                  buildButton("8", Colors.grey),
                  buildButton("9", Colors.grey),
                  buildButton("/", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("4", Colors.grey),
                  buildButton("5", Colors.grey),
                  buildButton("6", Colors.grey),
                  buildButton("*", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton("1", Colors.grey),
                  buildButton("2", Colors.grey),
                  buildButton("3", Colors.grey),
                  buildButton("-", Colors.orange),
                ],
              ),
              Row(
                children: [
                  buildButton(".", Colors.grey),
                  buildButton("0", Colors.grey),
                  buildButton("C", Colors.grey),
                  buildButton("+", Colors.orange),
                ],
              ),
              Row(children: [buildButton("=", Colors.green)]),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildButton(String buttonText, Color buttonColor) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: () => buttonPressed(buttonText),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.all(18),
            backgroundColor: buttonColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
          ),
          child: Text(
            buttonText,
            style: TextStyle(fontSize: 24, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
