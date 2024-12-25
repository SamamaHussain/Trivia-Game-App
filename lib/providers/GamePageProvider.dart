// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:html/parser.dart';
import 'package:trivia_game_app/utillities/colors.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  int currentQuestionCount = 0;
  List? questions;
  bool? isCorrect;
  int incorrectAnswerCount = 0;
  int correctAnswerCount = 0;
  BuildContext context;
  GamePageProvider({
    required this.context,
  }) {
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    print("Provider initialized");
    _getQuestions();
  }

  Future<void> _getQuestions() async {
    try {
      var _response = await _dio.get("", queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': 'easy',
      });
      var _data = jsonDecode(_response.toString());
      questions = _data['results'];
      print(questions);
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }

  String getCurrentQuestionText() {
    String _question = questions![currentQuestionCount]['question'];
    var document = parse(_question);
    String _unescapedQuestion =
        parse(document.body!.text).documentElement!.text;
    return _unescapedQuestion;
  }

  void answerQuestion(String answer) {
    if (answer == questions![currentQuestionCount]['correct_answer']) {
      isCorrect = true;
      print("Correct");
      currentQuestionCount++;
      correctAnswerCount++;
      makeDialog('Correct', Icons.check_circle_outline_rounded, greenColor);
    } else {
      isCorrect = false;
      print("Incorrect");
      currentQuestionCount++;
      incorrectAnswerCount++;
      makeDialog('Incorrect', Icons.cancel_outlined, redColor);
    }
    if (currentQuestionCount == _maxQuestions) {
      endGame();
      print("Game Over");
    }
    else{
      notifyListeners();
    }
  }

 void resetGame(){
   currentQuestionCount = 0;
   correctAnswerCount = 0;
   incorrectAnswerCount = 0;
   notifyListeners();
 }

// Widgets for the game page
endGame(){
  showDialog(
          context: context,
          builder: (BuildContext context) { 
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(width: 3, color: Colors.black),
          ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    const Text(
                          'Game Over',
                          style: TextStyle(
                              fontSize: 30,
                              color: purpleColor,
                              fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 10),
                    Text(
                          'Score: $correctAnswerCount / ${_maxQuestions}',
                          style: const TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                
                  ],
                ),
              ),
              actions: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    TextButton(onPressed: () {
                      currentQuestionCount = 0;
                      Navigator.pop(context);
                      Navigator.pop(context);
                      notifyListeners();
                    }, child: const Text('Retry',style: TextStyle(
                            fontSize: 20,
                            color: purpleColor,
                            fontWeight: FontWeight.bold),)),
                    TextButton(onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }, child: const Text('Close',style: TextStyle(
                            fontSize: 20,
                            color: purpleColor,
                            fontWeight: FontWeight.bold),)),
                  ],
                ),
              ],
            );
          });
}

  void makeDialog (String answer,IconData icon,Color color)async{
    showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(width: 3, color: Colors.black),
          ),
              content: Wrap(
                alignment: WrapAlignment.center,
                children: [
                   Text(
                    answer,
                    style: const TextStyle(
                        fontSize: 35,
                        color: purpleColor,
                        fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 3),
                   Icon(
                    icon,
                    color: color,
                    size: 35,
                  ),
                ],
              ),
            );
          });
          if(currentQuestionCount != _maxQuestions){
          await Future.delayed(const Duration(milliseconds: 1000),);
          Navigator.pop(
              context);}
  }
}
