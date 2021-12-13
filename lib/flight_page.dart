import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class FlightPage extends StatelessWidget {
  const FlightPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              height: MediaQuery.of(context).size.height * 0.32,
              left: 0,
              right: 0,
              child: const DecoratedBox(
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Color(0xffe04148), Color(0xffd85774)])),
              ),
            ),
            Positioned(
              left: 10,
              right: 10,
              top: MediaQuery.of(context).size.height * 0.32 / 2,
              bottom: 0,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child:
                    Column(children: List.generate(5, (index) => buildItems())),
              ),
            )
          ],
        ),
      ),
    );
  }
}

Widget buildItems() {
  return TweenAnimationBuilder(
    tween: Tween(begin: 0.0, end: 1.0),
    curve: Curves.decelerate,
    duration: const Duration(milliseconds: 1000),
    builder: (context, double value, child) {
      return Transform.scale(
        scale: value,
        child: child,
      );
    },
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 65,
        width: double.infinity,
        color: Colors.green,
        child: const Center(
            child: Text(
          'Item ',
          style: TextStyle(color: Colors.white, fontSize: 16),
        )),
      ),
    ),
  );
}
