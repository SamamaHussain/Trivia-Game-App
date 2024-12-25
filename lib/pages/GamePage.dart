import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_game_app/pages/HomePage.dart';
import 'package:trivia_game_app/providers/GamePageProvider.dart';
import 'package:trivia_game_app/utillities/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double? _deviceWidth, _deviceHeight;
GamePageProvider? _gamePageProvider;

// ignore: camel_case_types
class gamePage extends StatelessWidget {
  const gamePage({super.key});
  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (context) => GamePageProvider(context: context),
      child: _buildUI(),
    );
  }
}

Widget _buildUI() {
  return Builder(builder: (context) {
    _gamePageProvider = context.watch<GamePageProvider>();
    if (_gamePageProvider!.questions != null) {
      return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(_deviceHeight! * 0.01),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          homeButtonDialog(
                              'Are you sure you want to exit?',
                              context,_gamePageProvider!.resetGame);
                        },
                        icon: const Icon(
                          // ignore: deprecated_member_use
                          FontAwesomeIcons.homeAlt,
                          size: 27,
                          color: purpleColor,
                        ),
                      ),
                      const Text(
                        'Trivia Game',
                        style: TextStyle(
                            fontSize: 36,
                            color: purpleColor,
                            fontWeight: FontWeight.bold),
                      ),
                      IconButton(
                        onPressed: () {
                          showInstructionsDialog(context);
                        },
                        icon: const Icon(
                          // ignore: deprecated_member_use
                          FontAwesomeIcons.infoCircle,
                          size: 27,
                          color: purpleColor,
                        ),
                      ),
                    ],
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _deviceHeight! * 0.8,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.symmetric(
                            horizontal: _deviceHeight! * 0.05),
                        child: _gameUI(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(
          color: purpleColor,
          strokeWidth: 5.0,
        ),
      );
    }
  });
}

Widget _gameUI() {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxHeight: _deviceHeight! * 0.8,
    ),
    child: SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Question #${_gamePageProvider!.currentQuestionCount + 1}',
              style: const TextStyle(
                  fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold)),
          SizedBox(height: _deviceHeight! * 0.05),
          _qeustionUI(),
          SizedBox(height: _deviceHeight! * 0.1),
          Column(
            children: [
              _trueButton(),
              SizedBox(height: _deviceHeight! * 0.05),
              _falseButton(),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _qeustionUI() {
  return Text(
    _gamePageProvider!.getCurrentQuestionText(),
    style: const TextStyle(
      fontSize: 20,
      color: Colors.black,
      fontWeight: FontWeight.bold,
    ),
  );
}

Widget _trueButton() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          blurRadius: 0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: MaterialButton(
      onPressed: () {
        _gamePageProvider?.answerQuestion('True');
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(color: Colors.black, width: 2.9),
      ),
      color: greenColor,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.1,
      child: const Text(
        "True",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

Widget _falseButton() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20.0),
      boxShadow: const [
        BoxShadow(
          color: Colors.black,
          blurRadius: 0,
          offset: Offset(0, 2),
        ),
      ],
    ),
    child: MaterialButton(
      onPressed: () {
        _gamePageProvider?.answerQuestion('False');
      },
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
        side: const BorderSide(color: Colors.black, width: 2.9),
      ),
      color: redColor,
      minWidth: _deviceWidth! * 0.8,
      height: _deviceHeight! * 0.1,
      child: const Text(
        "False",
        style: TextStyle(
            fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    ),
  );
}

void homeButtonDialog(String answer, BuildContext context,void Function() voidFunction) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(width: 3, color: Colors.black),
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  answer,
                  style: const TextStyle(
                      fontSize: 20,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          actions: [
            Center(
              child: Wrap(
                children: [
                  TextButton(
                      onPressed: () {
                        voidFunction();
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            ));
                      },
                      child: const Text(
                        'Yes',
                        style: TextStyle(
                            fontSize: 20,
                            color: purpleColor,
                            fontWeight: FontWeight.bold),
                      )),
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'No',
                        style: TextStyle(
                            fontSize: 20,
                            color: purpleColor,
                            fontWeight: FontWeight.bold),
                      )),
                ],
              ),
            ),
          ],
        );
      });}
  void showInstructionsDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
            side: const BorderSide(width: 3, color: Colors.black),
          ),
            content: const SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Follow these instructions to play the trivia game:',
                      style: TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.bold,),
                    ),
                    SizedBox(height: 10),
                        ListTile(
                          leading: Icon(Icons.stop_rounded, color: purpleColor),
                          title: Text('You will be asked 10 questions.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                        ListTile(
                          leading: Icon(Icons.stop_rounded, color: purpleColor),
                          title: Text(
                              'Each question has two options: True or False.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                        ListTile(
                          leading: Icon(Icons.stop_rounded, color: purpleColor),
                          title: Text('Select "True" or "False" as your answer.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                        ListTile(
                          leading: Icon(Icons.stop_rounded, color: purpleColor),
                          title: Text(
                              'You will get a score based on your correct answers.',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                        ),
                  ],
                ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Close',
                        style: TextStyle(
                            fontSize: 20,
                            color: purpleColor,
                            fontWeight: FontWeight.bold),
                      ),
                    )),
              ),
            ],
          );
        });
  }
