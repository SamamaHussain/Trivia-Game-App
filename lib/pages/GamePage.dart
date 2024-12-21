import 'package:flutter/material.dart';
import 'package:trivia_game_app/utillities/colors.dart';

double? _deviceWidth, _deviceHeight;
class gamePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return _buildUI();
  }
}

Widget _buildUI() {
  return Scaffold(
    body: SafeArea(child: Container(
      color: purpleColor,
      padding: EdgeInsets.symmetric(horizontal: _deviceHeight! * 0.05),
      child: _gameUI(),
      ),
    ),
  );
}

  Widget _gameUI (){
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _qeustionUI(),
      ],
    );
  }

 Widget _qeustionUI(){
  return Text("Question: 1, Nothing Interesting",style: TextStyle(fontSize: 20,color: Colors.black),);
 }