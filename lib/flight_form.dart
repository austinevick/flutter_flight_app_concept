import 'package:flutter/material.dart';

class FlightForm extends StatelessWidget {
  final VoidCallback? onPressed;
  const FlightForm({Key? key, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Icon(Icons.flight_takeoff, color: Colors.red),
              SizedBox(width: 10),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(hintText: 'From'),
              ))
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: const [
              Icon(Icons.flight_takeoff, color: Colors.red),
              SizedBox(width: 10),
              Expanded(
                  child: TextField(
                decoration: InputDecoration(hintText: 'To'),
              ))
            ],
          ),
        ),
        const Spacer(),
        FloatingActionButton(
          backgroundColor: Colors.red,
          onPressed: onPressed,
          child: const Icon(Icons.multiline_chart),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}
