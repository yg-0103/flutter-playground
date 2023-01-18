import 'dart:async';

import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  static const minutes = 1500;
  int totalSeconds = minutes;
  bool isRunning = false;
  int totalPomodoros = 0;
  late Timer timer;

  void tick(Timer timer) {
    if (totalSeconds == 0) {
      timer.cancel();
      setState(() {
        totalPomodoros += 1;
        totalSeconds = minutes;
        isRunning = false;
      });
    } else {
      setState(() {
        totalSeconds -= 1;
      });
    }
  }

  void play() {
    timer = Timer.periodic(
      const Duration(seconds: 1),
      tick,
    );
  }

  void pause() {
    timer.cancel();
  }

  void onPressed() {
    isRunning ? pause() : play();

    setState(() {
      isRunning = !isRunning;
    });
  }

  void onReset() {
    timer.cancel();
    setState(() {
      totalSeconds = minutes;
      isRunning = false;
    });
  }

  String format(int seconds) {
    var duration =
        Duration(seconds: seconds).toString().split('.').first.substring(2);

    return duration;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Column(
        children: [
          Flexible(
            flex: 1,
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                format(totalSeconds),
                style: TextStyle(
                  color: Theme.of(context).cardColor,
                  fontSize: 85,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          Flexible(
            flex: 2,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    onPressed: onPressed,
                    icon: Icon(isRunning
                        ? Icons.pause_circle_outlined
                        : Icons.play_circle_outline),
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                  ),
                  IconButton(
                    onPressed: onReset,
                    icon: const Icon(Icons.refresh),
                    iconSize: 80,
                    color: Theme.of(context).cardColor,
                  ),
                ],
              ),
            ),
          ),
          Flexible(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(30)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Pomodoros',
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1?.color),
                        ),
                        Text(
                          '$totalPomodoros',
                          style: TextStyle(
                              fontSize: 58,
                              fontWeight: FontWeight.w600,
                              color:
                                  Theme.of(context).textTheme.headline1?.color),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
