import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConfettiScreen extends StatefulWidget {
  const ConfettiScreen({super.key});

  @override
  State<ConfettiScreen> createState() => _ConfettiScreenState();
}

class _ConfettiScreenState extends State<ConfettiScreen> {
  bool isPlaying = false;
  final controller = ConfettiController();

  @override
  void initState() {
    super.initState();
    controller.addListener(
      () {
        setState(
          () {
            isPlaying = controller.state == ConfettiControllerState.playing;
          },
        );
      },
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Scaffold(
          appBar: AppBar(
            title: const Text(
              'Confetti Example',
            ),
            centerTitle: true,
          ),
          body: Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: isPlaying ? Colors.red : Colors.teal,
              ),
              onPressed: () {
                if (isPlaying) {
                  controller.stop();
                } else {
                  controller.play();
                }
              },
              child: Text(
                isPlaying ? 'Stop' : 'Play',
              ),
            ),
          ),
        ),
        ConfettiWidget(
          confettiController: controller,
          shouldLoop: true,
          blastDirectionality: BlastDirectionality.explosive,
          emissionFrequency: 0.02,
          numberOfParticles: 100,
          minBlastForce: 1,
          maxBlastForce: 10,
          gravity: 0.2,
        ),
      ],
    );
  }
}
