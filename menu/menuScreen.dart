import 'dart:io';
import 'package:cro/gui.dart';
import 'package:cro/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';



class MenuScreen extends StatelessWidget {
    // const MenuScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
          children: [
            Positioned.fill(
              child: Image.asset("assets/bgmenu.png", 
              fit: BoxFit.fill,)
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(padding: EdgeInsets.all(10.0),
                    child: ElevatedButton(
                              child: const Text('Play game', 
                              style: TextStyle(
                                color:  Color.fromARGB(255, 12, 105, 122),
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const MyApp()),
                                );
                              },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          ),
                            ),
                  ),
                  Padding(padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                              child: const Text('Guideline', style: TextStyle(
                                color:  Color.fromARGB(255, 12, 105, 122),
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Guiline()),
                                );
                              },
                          style: ElevatedButton.styleFrom(
                              primary:Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.symmetric(horizontal: 43, vertical: 15),
                          ),
                            ),
                  ),
                  Padding(padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                              child: const Text(' Exit app ', style: TextStyle(
                                color:  Color.fromARGB(255, 12, 105, 122),
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                            exit(0);
                              },
                          style: ElevatedButton.styleFrom(
                              primary: Color.fromARGB(255, 255, 255, 255),
                              padding: EdgeInsets.symmetric(horizontal: 43, vertical: 15),
                          ),
                            ),
                  ),

                ],
              ),
            ),
          ],
        );
  }
}
