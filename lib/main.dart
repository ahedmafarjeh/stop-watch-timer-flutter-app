import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(useMaterial3: true),
      home: CounterDown(),
    );
  }
}

class CounterDown extends StatefulWidget {
  const CounterDown({super.key});

  @override
  State<CounterDown> createState() => _CounterDownState();
}

class _CounterDownState extends State<CounterDown> {
  Duration duration = Duration(seconds: 0);
  bool isStartPressed = false;
  String str = "Stop Timer";
  Timer? timerHndler;
  count() {
    timerHndler = Timer.periodic(Duration(microseconds: 1), (timer) {
      setState(() {
        int newDuration = duration.inSeconds + 1;
        duration = Duration(seconds: newDuration);

        // if (seconds < 60) {
        //   seconds++;
        // } else if (minutes < 60) {
        //   seconds = 0;
        //   minutes++;
        // } else {
        //   minutes = 0;
        //   hours++;
        // }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 33, 40, 34),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11)),
                        child: Text(
                            "${duration.inHours.toString().padLeft(2, "0")}",
                            style:
                                TextStyle(color: Colors.black, fontSize: 80)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Hours",
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11)),
                        child: Text(
                            "${duration.inMinutes.remainder(60).toString().padLeft(2, "0")}",
                            //reminder(60) -- عشان ما تتجاوز قيمة الدقائق 60 ، فلما توصل 60 بترجع من الاول على الصفر
                            style:
                                TextStyle(color: Colors.black, fontSize: 80)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Minutes",
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    ],
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(11)),
                        child: Text(
                            "${duration.inSeconds.remainder(60).toString().padLeft(2, "0")}",
                            style:
                                TextStyle(color: Colors.black, fontSize: 80)),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Seconds",
                        style: TextStyle(color: Colors.white, fontSize: 23),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              isStartPressed
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            //check if the timer is runing
                            if (timerHndler!.isActive) {
                              setState(() {
                                // stop timer
                                timerHndler!.cancel();
                              });
                            } else {
                              // run timer
                              count();
                            }
                            // setState(() {
                            //   if (str == "resume") {
                            //   count();
                            //   str = "Stop Timer";
                            // } else {
                            //   timerHndler!.cancel();

                            //     str = "resume";

                            // }
                            // });
                          },
                          child: Text(
                              timerHndler!.isActive ? "Stop Timer" : "Resume",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.pinkAccent[100]),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            timerHndler!.cancel();
                            setState(() {
                              duration = Duration(seconds: 0);
                              isStartPressed = false;
                            });
                          },
                          child: Text("Cancel",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 25)),
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                Colors.pinkAccent[100]),
                          ),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        count();
                        setState(() {
                          isStartPressed = true;
                        });
                      },
                      child: Text("Start Timer",
                          style: TextStyle(color: Colors.white, fontSize: 25)),
                      style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.blue),
                      ),
                    ),
            ],
          ),
        ));
  }
}
