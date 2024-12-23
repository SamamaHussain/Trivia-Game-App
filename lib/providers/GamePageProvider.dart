// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class GamePageProvider extends ChangeNotifier {
  final Dio _dio = Dio();
  final int _maxQuestions = 10;
  int _currentQuestionCount = 0;
  List? questions; 
  BuildContext context;
  GamePageProvider({
    required this.context,
  }){
    _dio.options.baseUrl = "https://opentdb.com/api.php";
    print("Provider initialized");
    _getQuestions();
  }

  Future<void> _getQuestions() async{
    try{
    var _response = await _dio.get("",queryParameters: {
        'amount': 10,
        'type': 'boolean',
        'difficulty': 'easy',
    });
    var _data= jsonDecode(_response.toString());
    questions=_data['results'];
    print(questions);
    notifyListeners();
  } catch(e){
    print(e);
  }
  }

  String getCurrentQuestionText (){
    return questions![_currentQuestionCount]['question'];
  }
}
