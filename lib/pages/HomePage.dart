import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trivia_game_app/pages/GamePage.dart';
import 'package:trivia_game_app/utillities/colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

double? _deviceWidth, _deviceHeight;


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
        _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxHeight: _deviceHeight!*0.8
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Column(
                          children: [
                            Container(
                              height: 120,
                              width: 120,
                              decoration: BoxDecoration(
                                color: purpleColor,
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                              child: Icon(FontAwesomeIcons.splotch, size: 80.0, color: Colors.white,)),
                            const SizedBox(height: 20),
                             Wrap(
                               spacing: 8.0,
                               crossAxisAlignment: WrapCrossAlignment.center,
                               alignment: WrapAlignment.center,
                               children: [
                                 Text(
                                  maxLines: 1,
                                   'Trivia',
                                   style: GoogleFonts.manrope(fontSize: 50.0,
                                       color: purpleColor,
                                       fontWeight: FontWeight.w900),
                                 ),
                                 Text(
                                  maxLines: 1,
                                   'App',
                                   style: GoogleFonts.manrope(fontSize: 50.0,
                                       color: Colors.black,
                                       fontWeight: FontWeight.w900,),
                                 ),
                               ],
                             ),
                          ],
                        ),
                        SizedBox(height: _deviceHeight!*0.05),
                        ConstrainedBox(
                          constraints:  const BoxConstraints(
                            maxWidth: 400,
                          ),
                          child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                                ListTile(
                                  leading: Icon(Icons.stop_rounded, color: purpleColor,size: 35,),
                                  title: Text('Challenge yourself with exciting trivia questions!',maxLines: 2,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                                ),
                                ListTile(
                                  leading: Icon(Icons.stop_rounded, color: purpleColor,size: 35,),
                                  title: Text('Compete with friends and family',maxLines: 2,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                                ),
                                ListTile(
                                  leading: Icon(Icons.stop_rounded, color: purpleColor,size: 35,),
                                  title: Text(
                                      'Test your knowledge on various topics.',maxLines: 2,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 17),),
                                ),
                          ],
                                          ),
                        ),
                        SizedBox(height: _deviceHeight!*0.05),
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            maxWidth: 450,
                            minWidth: _deviceWidth!*0.2,
                          ),
                          child: Container(
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0),
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
                                Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(builder: (context) => gamePage()),
                                  (Route<dynamic> route) => false, // Remove all routes
                                );
                              },
                              minWidth: _deviceWidth! * 0.8,
                              height: _deviceHeight! * 0.1,
                              color: purpleColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                                side: const BorderSide(color: Colors.black, width: 2.9),
                              ),
                                      child: const Text(
                                        maxLines: 1,
                                        'Play Now!',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  alignment: Alignment.bottomCenter,
                  child: const Text(
                    'Made by Samama Hussain',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        fontWeight: FontWeight.w100),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
