import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:trivia_game_app/providers/GamePageProvider.dart';
import 'package:trivia_game_app/utillities/colors.dart';

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
            child: Stack(
              children: [
                Align(
                  child: Text(
                    'Trivia Game',
                    style: TextStyle(
                        fontSize: 35,
                        color: purpleColor,
                        fontWeight: FontWeight.bold),
                  ),
                  alignment: Alignment.topCenter,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      color: Colors.white,
                      padding:
                          EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
                      child: _gameUI(),
                    ),
                  ],
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
  return Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Question #${_gamePageProvider!.currentQuestionCount + 1}',
              style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
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
      );
}

Widget _qeustionUI() {
  return Text(
    _gamePageProvider!.getCurrentQuestionText(),
    style: TextStyle(
        fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),
  );
}



Widget _trueButton() {
  return MaterialButton(
    onPressed: () {
      _gamePageProvider?.answerQuestion('True');
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: const BorderSide(color: Colors.black, width: 3.0),
    ),
    color: greenColor,
    minWidth: _deviceWidth! * 0.8,
    height: _deviceHeight! * 0.1,
    child: const Text(
      "True",
      style: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}

Widget _falseButton() {
  return MaterialButton(
    onPressed: () {
      _gamePageProvider?.answerQuestion('False');
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(20.0),
      side: const BorderSide(color: Colors.black, width: 3.0),
    ),
    color: redColor,
    minWidth: _deviceWidth! * 0.8,
    height: _deviceHeight! * 0.1,
    child: const Text(
      "False",
      style: TextStyle(
          fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
    ),
  );
}
