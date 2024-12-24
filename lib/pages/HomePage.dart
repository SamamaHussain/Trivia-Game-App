import 'package:flutter/material.dart';
import 'package:trivia_game_app/pages/GamePage.dart';
import 'package:trivia_game_app/utillities/colors.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Trivia',
                        style: TextStyle(
                            fontSize: 40.0,
                            color: purpleColor,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 8),
                      Text(
                        'App',
                        style: TextStyle(
                            fontSize: 40.0,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Challenge yourself with exciting trivia questions!',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w100),
                  ),
                  Text(
                    'Test your knowledge on various topics.',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w100),
                  ),
                  Text(
                    'Compete with friends and family!',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.black,
                        fontWeight: FontWeight.w100),
                  ),
                  SizedBox(height: 40),
                  MaterialButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => gamePage()),
                        (Route<dynamic> route) => false, // Remove all routes
                      );
                    },
                    color: purpleColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      side: BorderSide(color: Colors.black, width: 2.9),
                    ),
                    padding:
                        EdgeInsets.symmetric(horizontal: 170.0, vertical: 18.0),
                    child: Text(
                      'Play Now!',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Made by Samama Hussain',
                  style: TextStyle(
                      fontSize: 10.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w100),
                ),
              ),
              // Positioned(
              //   bottom: 0,
              //   child: Container(
              //     height: 500,
              //     width: 500,
              //     decoration: BoxDecoration(color: purpleColor,borderRadius: const BorderRadius.all(Radius.circular(100.0))),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
