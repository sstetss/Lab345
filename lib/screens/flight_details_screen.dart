import 'package:flutter/material.dart';

class FlightDetailsScreen extends StatelessWidget {
  final dynamic flight;

  FlightDetailsScreen({required this.flight});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flight Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Flight Number: ${flight['flight_number']}'),
            Text('Departure: ${flight['departure_at']}'),
            Text('Price: \$${flight['price']}'),
            Text('Airline: ${flight['airline']}'),
            // Інші деталі рейсу...
          ],
        ),
      ),
    );
  }
}
