import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:math_expressions/math_expressions.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userInput = '';
  String result = '0';
  String userNumber = '0';
  List buttonsList = [
    'C',
    '(',
    ')',
    '/',
    '7',
    '8',
    '9',
    '*',
    '4',
    '5',
    '6',
    '+',
    '1',
    '2',
    '3',
    '-',
    'AC',
    '0',
    '.',
    '='
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              Flexible(
                flex: 1,
                child: resultWidget(),
              ),
              Flexible(
                flex: 2,
                child: buttonsWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget resultWidget() {
    return Column(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              userInput,
              style: const TextStyle(
                fontSize: 32,
                color: Colors.white,
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerRight,
            child: Text(
              result,
              style: const TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buttonsWidget() {
    return Container(
      margin: const EdgeInsets.only(top: 35),
      child: GridView.builder(
        itemCount: buttonsList.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
        itemBuilder: (context, index) {
          return button(buttonsList[index]);
        },
      ),
    );
  }

  Widget button(String text) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: MaterialButton(
        onPressed: () {
          setState(() {
            handleButtonPress(text);
          });
        },
        color: getColor(text),
        textColor: Colors.white,
        shape: const CircleBorder(),
        child: Text(
          text,
          style: const TextStyle(fontSize: 25),
        ),
      ),
    );
  }

  getColor(String text) {
    if (text == 'C' || text == '(') {}
    if (text == '/' ||
        text == '*' ||
        text == '+' ||
        text == '-' ||
        text == '=') {
      return Colors.yellow;
    }
    if (text == '(' || text == ')') {
      return Colors.grey;
    }
    if (text == 'C' || text == 'AC') {
      return Colors.red;
    }
    return Colors.black;
  }

  void handleButtonPress(String text) {
    if (text == 'AC') {
      //Reset all
      userInput = '';
      result = '0';
      return;
    }

    if (text == 'C') {
      //Remove last char
      if (userInput.isNotEmpty) {
        userInput = userInput.substring(0, userInput.length - 1);
      } else {
        if (kDebugMode) {
          print('hello');
        }
      }
      return;
    }

    if (text == '=') {
      //Calculate the result
      result = calculate();
      return;
    }
    userInput = userInput + text;
  }

  String calculate() {
    try {
      var exp = Parser().parse(userInput);
      var evolution = exp.evaluate(EvaluationType.REAL, ContextModel());
      return evolution.toString();
    } catch (e) {
      return 'Error';
    }
  }
}
