import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_flight_app/flight_form.dart';

import 'flight_time_line.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

enum FlightView { form, timeline }

class _HomePageState extends State<HomePage> {
  bool isSelected = false;
  FlightView flightView = FlightView.form;
  void onFlightPressed() {
    setState(() => flightView = FlightView.timeline);
  }

  @override
  Widget build(BuildContext context) {
    final headerHeight = MediaQuery.of(context).size.height * 0.32;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              height: headerHeight,
              left: 0,
              right: 0,
              child: DecoratedBox(
                decoration: const BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffe04148), Color(0xffd85774)])),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const SizedBox(height: 12),
                      const Text(
                        'Air Nigeria',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildHeader('ONE WAY', true),
                          buildHeader('ROUND', false),
                          buildHeader('MULTICITY', true)
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              top: headerHeight / 2,
              bottom: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        buildTabButton('Flight', true),
                        buildTabButton('Train', false),
                        buildTabButton('Bus', false),
                      ],
                    ),
                    Expanded(
                        child: flightView == FlightView.form
                            ? FlightForm(
                                onPressed: onFlightPressed,
                              )
                            : const FlightTimeline())
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildTabButton(String text, bool isSelected) => Expanded(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Text(text,
                  style: TextStyle(
                    fontSize: 15,
                    color: isSelected ? Colors.red : Colors.grey,
                  )),
              const SizedBox(height: 15),
              Container(
                color: isSelected ? Colors.red : Colors.transparent,
                height: 2,
                width: 60,
              )
            ],
          ),
        ),
      );
  Widget buildHeader(String text, bool isSelected) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          onPressed: () {},
          child: Text(text,
              style: TextStyle(
                  color: !isSelected ? Colors.white : const Color(0xffe04148))),
          color: isSelected ? Colors.white : const Color(0xffe04148),
          height: 45,
          shape: OutlineInputBorder(
              borderSide: BorderSide(
                  color: !isSelected ? Colors.white : Colors.transparent),
              borderRadius: BorderRadius.circular(20)),
        ),
      );
}
