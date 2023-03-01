import 'package:animations/animations.dart';
import 'package:counter_client/main.dart';
import 'package:counter_client/screens/learning_module/learning_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LearningPath extends StatefulWidget {
  const LearningPath({Key? key}) : super(key: key);

  @override
  State<LearningPath> createState() {
    return _LearningPathState();
  }
}

class _LearningPathState extends State<LearningPath> {
  int _currentIndex = 0;
  bool isReverse = false;

  final List<Widget> _screens = const [
    WhatStock(),
    WhyInvest(),
    HowInvest(),
    InvestTechnique(),
    Keywords(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Learning Path',
            style: GoogleFonts.robotoMono(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            )),
        elevation: 0,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Text(
              '${_currentIndex + 1} / ${_screens.length.toString()}',
              style: GoogleFonts.robotoMono(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: const Color.fromARGB(255, 245, 188, 188),
              ),
            ),
            Expanded(
              child: PageTransitionSwitcher(
                reverse: isReverse,
                transitionBuilder: (
                  Widget child,
                  Animation<double> animation,
                  Animation<double> secondaryAnimation,
                ) {
                  return SharedAxisTransition(
                    animation: animation,
                    secondaryAnimation: secondaryAnimation,
                    transitionType: SharedAxisTransitionType.horizontal,
                    child: child,
                  );
                },
                child: _screens[_currentIndex],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  TextButton(
                    onPressed: _currentIndex == 0
                        ? null
                        : () {
                            setState(() {
                              _currentIndex--;
                              isReverse = true;
                            });
                          },
                    child: const Text('BACK'),
                  ),
                  ElevatedButton(
                    onPressed: _currentIndex == _screens.length - 1
                        ? () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => HomePage()),
                            );
                          }
                        : () {
                            setState(() {
                              _currentIndex++;
                              isReverse = false;
                            });
                          },
                    child: _currentIndex == _screens.length - 1
                        ? const Text('Move to Dashboard')
                        : const Text('NEXT'),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
