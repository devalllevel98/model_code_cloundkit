// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';

import 'game.dart';
import 'package:action_slider/action_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.black,
        image: DecorationImage(
          image: AssetImage("assets/02.jpeg"),
          fit: BoxFit.fitHeight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Spacer(),
          Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Color.fromARGB(255, 13, 32, 236),
                        toggleColor: Color(0xffffffff),
                        icon: Icon(
                          Icons.play_arrow_outlined,
                          color:  Color.fromARGB(255, 148, 13, 238),
                          size: height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Play Game',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: height*0.022,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        action: (controller) async {
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 3));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => GamePage()),
                            (Route<dynamic> route) => false,
                          );
                          controller.success();
                        },
                      ),
                    SizedBox(height: 30.0),
                    ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Color.fromARGB(255, 200, 168, 247),
                        toggleColor: Color(0xffffffff),
                        icon: Icon(
                          Icons.gite_outlined,
                          color:  Color.fromARGB(255, 148, 13, 238),
                          size: height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Guideline',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: height*0.022,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        action: (controller) async {
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 3));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => GamePage()),
                            (Route<dynamic> route) => false,
                          );
                          controller.success();
                        },
                      ),
                  SizedBox(height: 30.0),
                                        ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Color.fromARGB(255, 224, 10, 53),
                        toggleColor: Color(0xffffffff),
                        icon: Icon(
                          Icons.exit_to_app_outlined,
                          color:  Color.fromARGB(255, 148, 13, 238),
                          size: height * 0.05,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: width*0.08),
                            Text('Quit Game',
                                style: TextStyle(
                                    color: Color(0xffffffff),
                                    fontSize: height*0.022,
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        action: (controller) async {
                          controller.loading();
                          await Future.delayed(const Duration(seconds: 3));
                          exit(0);
                          // controller.success();
                        },
                      ),
                  SizedBox(height: 30.0),
                  ],
                  
                ),

              ),

        ],
      ),
    ));
  }
}
//action_slider: ^0.6.1
