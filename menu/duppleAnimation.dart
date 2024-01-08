// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:action_slider/action_slider.dart';
import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'package:tetramind/board.dart';
import 'package:tetramind/gui.dart';



class HomePage extends StatefulWidget {
  //  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePage();
}
class _HomePage extends State<HomePage> with TickerProviderStateMixin {
  get score => null;

  @override
  Widget build(BuildContext context) {
        double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 50,
            spawnMinSpeed: 10.00,
            particleCount: 68,
            spawnMaxSpeed: 50,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            baseColor:  Colors.blue,
            // image: Image(image: AssetImage('assets/anilogo.png')),
          ),
        ),
        vsync: this,
        child:  Container(
      width: width,
      height: height,
      // decoration: BoxDecoration(
      //   color: Colors.black,
      //   image: DecorationImage(
      //     image: AssetImage("assets/02.jpeg"),
      //     fit: BoxFit.fitHeight,
      //   ),
      // ),
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
                        backgroundColor: Colors.transparent,
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
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => const Board()),
                            (Route<dynamic> route) => false,
                          );
                          controller.success();
                        },
                      ),
                    SizedBox(height: 30.0),
                    ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Colors.transparent,
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
                          await Future.delayed(const Duration(seconds: 2));
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) => Guiline()),
                            (Route<dynamic> route) => false,
                          );
                          controller.success();
                        },
                      ),
                  SizedBox(height: 30.0),
                                        ActionSlider.standard(
                        width: width * 0.6,
                        backgroundColor: Colors.transparent,
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
                          await Future.delayed(const Duration(seconds: 2));
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
    )
      ),
    );
  }
}




