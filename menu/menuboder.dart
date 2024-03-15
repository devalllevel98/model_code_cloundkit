import 'dart:io';
import 'package:birdandplan/gui.dart';
import 'package:birdandplan/homepage.dart';
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
                              child: const Text('Play Game', 
                              style: TextStyle(
                                color:  Color.fromARGB(255, 255, 255, 255),
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => HomePage()),
                                );
                              },
                           style: ButtonStyle(
                        
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0), // Điều chỉnh độ cong của border
                              side: BorderSide(color: Color.fromARGB(255, 123, 255, 0), width: 2.0), // Điều chỉnh màu sắc và độ dày của border
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent), 
                        ),
                            ),
                  ),
                  Padding(padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                              child: const Text('Guideline', style: TextStyle(
                                color:  Color.fromARGB(255, 255, 255, 255),
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Guiline()),
                                );
                              },
                  style: ButtonStyle(
                  
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0), // Điều chỉnh độ cong của border
                        side: BorderSide(color: Color.fromARGB(255, 123, 255, 0), width: 2.0), // Điều chỉnh màu sắc và độ dày của border
                      ),
                    ),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent), 
                  ),
                            ),
                  ),
                  Padding(padding: EdgeInsets.all(15.0),
                    child: ElevatedButton(
                              child: const Text(' Exit app ', style: TextStyle(
                                color:  Color.fromARGB(255, 255, 255, 255),
                              fontSize: 21,
                              fontWeight: FontWeight.bold
                              ),),
                          onPressed: () {
                            exit(0);
                              },
                          style: ButtonStyle(
                          
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0), // Điều chỉnh độ cong của border
                                side: BorderSide(color: Color.fromARGB(255, 123, 255, 0), width: 2.0), // Điều chỉnh màu sắc và độ dày của border
                              ),
                            ),
                            backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent), 
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
