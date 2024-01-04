

import 'package:animated_background/animated_background.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:tetramind/menu.dart';


class Guiline extends StatefulWidget {
  // const Guiline({Key? key}) : super(key: key);

  @override
  State<Guiline> createState() => _GuilineState();
}

class _GuilineState extends State<Guiline> with TickerProviderStateMixin {
  @override
    @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
              appBar: AppBar(
          title: const Text('Guideline',
              style: TextStyle(
                color: Color.fromARGB(255, 244, 1, 1),
                fontWeight: FontWeight.bold,
                fontSize: 18,
              )),
          backgroundColor:  Colors.transparent,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 244, 2, 2)),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          centerTitle: true,
        ),
      body: AnimatedBackground(
        behaviour: RandomParticleBehaviour(
          options: const ParticleOptions(
            spawnMaxRadius: 50,
            spawnMinSpeed: 10.00,
            particleCount: 68,
            spawnMaxSpeed: 50,
            minOpacity: 0.3,
            spawnOpacity: 0.4,
            baseColor: Colors.blue,
            // image: Image(image: AssetImage('assets/anilogo.png')),
          ),
        ),
        vsync: this,
        child:Stack(
          children: [
            Positioned.fill(
                child: Image.asset(
              "assets/gui.png",
              fit: BoxFit.fill,
            ))
          ],
        ),

      ),
    );
  }
}
//  animated_background: ^2.0.0