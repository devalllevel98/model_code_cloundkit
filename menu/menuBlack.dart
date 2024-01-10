import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

 

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 

  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      backgroundColor: Colors.black,
      body:Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('assets/background.jpeg'),fit: BoxFit.cover)
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 40,top: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  
                      Text('',style: TextStyle(fontSize: 40),),
                      Text('Welcome',style: TextStyle(color:Colors.white,fontSize: 35,fontWeight: FontWeight.bold),),
                      Text('Manage Tasks easly',style: TextStyle(color:Colors.white,fontSize: 30,),),
                      Text('For ever!',style: TextStyle(color:Color.fromARGB(255, 255, 255, 255),fontSize: 25,),),
                      
                      // Expanded(child: Container()),
                      
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Expanded(child: Container()),
                            SizedBox(height: 70,),
                            GestureDetector(
                              onTap: () {
                                Get.to(HomePage());
                              },
                              child: Container(
                                width: 200,
                                height: 38,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(
                                    color: Color.fromARGB(255, 28, 48, 82),
                                    blurRadius: 5,spreadRadius: 1,offset: Offset(3, 2)
                                  )],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 19, 19, 19)
                                ),
                                child: Center(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Manage Task  ',style: TextStyle(fontSize: 16,color: Colors.white),),Icon(Icons.keyboard_double_arrow_right_outlined,color: Colors.white,)],
                                )),
                              ),
                            ),
                            SizedBox(height: 20,),
                             GestureDetector(
                              onTap: () {
                                 Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => Guiline()),
                                );
                              },
                              child: Container(
                                width: 200,
                                height: 38,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(
                                    color: Color.fromARGB(255, 28, 48, 82),
                                    blurRadius: 5,spreadRadius: 1,offset: Offset(3, 2)
                                  )],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 19, 19, 19)
                                ),
                                child: Center(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Guideline ',style: TextStyle(fontSize: 16,color: Colors.white),),Icon(Icons.keyboard_double_arrow_right_outlined,color: Colors.white,)],
                                )),
                              ),
                            ),
                          SizedBox(height: 20,),
                             GestureDetector(
                              onTap: () {
                                exit(0);
                              },
                              child: Container(
                                width: 200,
                                height: 38,
                                decoration: BoxDecoration(
                                  boxShadow: [BoxShadow(
                                    color: Color.fromARGB(255, 28, 48, 82),
                                    blurRadius: 5,spreadRadius: 1,offset: Offset(3, 2)
                                  )],
                                  borderRadius: BorderRadius.circular(10),
                                  color: Color.fromARGB(255, 19, 19, 19)
                                ),
                                child: Center(child:Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [Text('Quit App ',style: TextStyle(fontSize: 16,color: Colors.white),),Icon(Icons.keyboard_double_arrow_right_outlined,color: Colors.white,)],
                                )),
                              ),
                            ),


                          ],
                        ),
                      )
                ],
              ),
            ),
          ),
        ),
      )
    );
    
  }
}

//dev_dependencies:
  // flutter_test:
  //   sdk: flutter
  // flutter_lints: ^2.0.0
  // build_runner: ^2.0.7
  // hive_generator: ^2.0.1