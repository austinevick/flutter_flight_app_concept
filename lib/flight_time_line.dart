import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'flight_page.dart';

const _airPlaneSize = 30.0;
const _dotSize = 15.0;

class FlightTimeline extends StatefulWidget {
  const FlightTimeline({Key? key}) : super(key: key);

  @override
  State<FlightTimeline> createState() => _FlightTimelineState();
}

class _FlightTimelineState extends State<FlightTimeline> {
  bool isAnimated = false;
  bool animateCards = false;
  bool animateButton = false;

  @override
  void initState() {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      init();
    });
    super.initState();
  }

  void init() async {
    setState(() => isAnimated = !isAnimated);
    await Future.delayed(const Duration(seconds: 1));
    setState(() => animateCards = true);
    await Future.delayed(const Duration(milliseconds: 300));
    setState(() => animateButton = true);
  }

  void onRouteTap() {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (_, animation, __) {
        return FadeTransition(
          opacity: animation,
          child: const FlightPage(),
        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      final centerDot = constraint.maxWidth / 2 - _dotSize / 2;
      return Stack(
        children: [
          AnimatedPositioned(
              duration: const Duration(milliseconds: 400),
              left: constraint.maxWidth / 2 - _airPlaneSize / 2,
              top: isAnimated ? 20 : constraint.maxHeight - _airPlaneSize - 10,
              bottom: 0,
              child: const AirCraftAndLine()),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 600),
              left: centerDot,
              top: isAnimated ? 80 : constraint.maxHeight,
              child: TimeLineDot(
                  delay: const Duration(milliseconds: 600),
                  displayCard: animateCards,
                  isSelected: false)),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 800),
              right: centerDot,
              top: isAnimated ? 140 : constraint.maxHeight,
              child: TimeLineDot(
                  delay: const Duration(milliseconds: 800),
                  displayCard: animateCards,
                  left: true,
                  isSelected: true)),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1000),
              left: centerDot,
              top: isAnimated ? 200 : constraint.maxHeight,
              child: TimeLineDot(
                  delay: const Duration(milliseconds: 1000),
                  displayCard: animateCards,
                  isSelected: true)),
          AnimatedPositioned(
              duration: const Duration(milliseconds: 1400),
              right: centerDot,
              top: isAnimated ? 260 : constraint.maxHeight,
              child: TimeLineDot(
                  delay: const Duration(milliseconds: 1400),
                  displayCard: animateCards,
                  left: true,
                  isSelected: false)),
          if (animateButton)
            TweenAnimationBuilder<double>(
                tween: Tween(begin: 0.0, end: 1.0),
                duration: const Duration(milliseconds: 300),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: FloatingActionButton(
                    backgroundColor: Colors.red,
                    onPressed: onRouteTap,
                    child: const Icon(Icons.done),
                  ),
                ),
                builder: (context, double value, child) {
                  return Transform.scale(scale: value, child: child);
                }),
        ],
      );
    });
  }
}

class AirCraftAndLine extends StatelessWidget {
  const AirCraftAndLine({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: _airPlaneSize,
      child: Column(
        children: [
          const Icon(
            Icons.flight,
            color: Colors.red,
            size: _airPlaneSize,
          ),
          Expanded(child: Container(width: 5, color: Colors.grey))
        ],
      ),
    );
  }
}

class TimeLineDot extends StatefulWidget {
  final bool isSelected;
  final bool displayCard;
  final bool left;
  final Duration? delay;
  const TimeLineDot(
      {Key? key,
      this.isSelected = false,
      this.displayCard = false,
      this.left = false,
      this.delay})
      : super(key: key);

  @override
  State<TimeLineDot> createState() => _TimeLineDotState();
}

class _TimeLineDotState extends State<TimeLineDot> {
  bool isanimated = false;
  void animateWithDelay() async {
    if (widget.displayCard) {
      await Future.delayed(widget.delay!);
    }
    setState(() => isanimated = true);
  }

  @override
  void didUpdateWidget(covariant TimeLineDot oldWidget) {
    animateWithDelay();
    super.didUpdateWidget(oldWidget);
  }

  Widget get buildCard => TweenAnimationBuilder(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        child: const Card(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Text('JKY + DRY'),
          ),
        ),
        builder: (context, double value, child) =>
            Transform.scale(scale: value, child: child),
      );

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (widget.displayCard && widget.left) ...[
          buildCard,
          Container(
            width: 10,
            height: 1,
            color: Colors.grey,
          )
        ],
        Container(
          height: _dotSize,
          width: _dotSize,
          decoration: BoxDecoration(
              color: Colors.grey,
              border: Border.all(color: Colors.white),
              shape: BoxShape.circle),
          child: Padding(
            padding: const EdgeInsets.all(0.5),
            child: CircleAvatar(
              backgroundColor: widget.isSelected ? Colors.red : Colors.green,
            ),
          ),
        ),
        if (widget.displayCard && !widget.left) ...[
          Container(
            width: 10,
            height: 1,
            color: Colors.grey,
          ),
          buildCard
        ],
      ],
    );
  }
}
