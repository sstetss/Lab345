import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab3_new_app/services/network_service.dart';
import 'package:lab3_new_app/screens/flight_details_screen.dart'; // Для деталів рейсу
import 'package:lab3_new_app/repositories/user_repository.dart'; // Для виходу
import 'package:lab3_new_app/screens/login_screen.dart'; // Додаємо імпорт LoginScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final networkService = Provider.of<NetworkService>(context);
    final userRepository = Provider.of<UserRepository>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flights from Poland'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () async {
              await userRepository.logoutUser();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()), // Тепер екран логіну доступний
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<List<dynamic>>(
        future: networkService.fetchFlights(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final flights = snapshot.data ?? [];

          return ListView.builder(
            itemCount: flights.length,
            itemBuilder: (context, index) {
              final flight = flights[index];
              return ListTile(
                title: Text('Flight to ${flight['destination']}'),
                subtitle: Text('Price: \$${flight['price']}'),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FlightDetailsScreen(flight: flight),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
