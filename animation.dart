// ignore_for_file: prefer_const_constructors

import 'package:animated_background/animated_background.dart';
import 'package:flutter/material.dart';
import 'game.dart';


class GameOver extends StatefulWidget {
  
   const GameOver({super.key, required this.score});
   final int score;
  @override
  State<GameOver> createState() => _GameOver();
}


class _GameOver extends State<GameOver> with TickerProviderStateMixin {
  get score => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            // image: Image(image: AssetImage('assets/Images/Flutter.png')),
          ),
        ),
        vsync: this,
        child: //${widget.score} container vao

      ),
    );
  }
}




