// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
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
    return questions![currentQuestionCount]['question'];
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
              content: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                        'Game Over',
                        style: TextStyle(
                            fontSize: 35,
                            color: purpleColor,
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                  Text(
                        'Score: $correctAnswerCount / ${_maxQuestions+1}',
                        style: TextStyle(
                            fontSize: 35,
                            color: purpleColor,
                            fontWeight: FontWeight.bold),
                      ),

                ],
              ),
              actions: [
                TextButton(onPressed: () {
                  Navigator.pop(context);
                  currentQuestionCount = 0;
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
            );
          });
}

  void makeDialog (String answer,IconData icon,Color color)async{
    showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: purpleColor,
              shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: BorderSide(width: 3, color: Colors.white),
          ),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                   Text(
                    answer,
                    style: TextStyle(
                        fontSize: 35,
                        color: Colors.white,
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
          await Future.delayed(Duration(milliseconds: 1000),);
          Navigator.pop(
              context);
  }
}
