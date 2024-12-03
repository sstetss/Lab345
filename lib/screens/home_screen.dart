import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab3_new_app/repositories/user_repository.dart';
import 'package:lab3_new_app/utils/dialog_utils.dart';
import 'package:lab3_new_app/services/network_service.dart';
import 'package:lab3_new_app/screens/login_screen.dart';

class Flight {
  String flightNumber;
  String departure;
  String destination;
  String date;

  Flight({required this.flightNumber, required this.departure, required this.destination, required this.date});
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Flight> flights = [
    Flight(flightNumber: 'AI202', departure: 'New York', destination: 'London', date: '2024-12-10'),
    Flight(flightNumber: 'BA303', departure: 'Paris', destination: 'Dubai', date: '2024-12-12'),
    Flight(flightNumber: 'LU404', departure: 'Tokyo', destination: 'Los Angeles', date: '2024-12-14'),
  ];

  @override
  void initState() {
    super.initState();
    _checkNetworkStatus();
    _autoLogin();
  }

  void _checkNetworkStatus() async {
    final networkService = Provider.of<NetworkService>(context, listen: false);
    final isConnected = await networkService.isConnected();

    if (!isConnected) {
      DialogUtils.showInfoDialog(context, 'You are not connected to the internet.');
    }
  }

  void _autoLogin() async {
    final userRepository = Provider.of<UserRepository>(context, listen: false);
    final networkService = Provider.of<NetworkService>(context, listen: false);
    final isConnected = await networkService.isConnected();

    if (isConnected) {
      final userData = await userRepository.getUserData();
      if (userData.isNotEmpty) {
        final loginSuccess = await userRepository.loginUser(
          userData['email'] ?? '',
          userData['password'] ?? '',
        );

        if (loginSuccess) {
          DialogUtils.showInfoDialog(context, 'Welcome back, ${userData['name']}!');
        } else {
          DialogUtils.showInfoDialog(context, 'Auto-login failed. Please login manually.');
        }
      }
    } else {
      DialogUtils.showInfoDialog(context, 'You need to connect to the internet to login.');
    }
  }

  void _logout() async {
    final userRepository = Provider.of<UserRepository>(context, listen: false);
    DialogUtils.showConfirmationDialog(
      context,
      'Do you really want to log out?',
          () async {
        await userRepository.logoutUser();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
    );
  }

  void _editFlight(int index) {
    final flight = flights[index];
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Edit Flight'),
        content: Column(
          children: [
            TextField(
              controller: TextEditingController(text: flight.flightNumber),
              decoration: InputDecoration(labelText: 'Flight Number'),
              onChanged: (value) => flight.flightNumber = value,
            ),
            TextField(
              controller: TextEditingController(text: flight.departure),
              decoration: InputDecoration(labelText: 'Departure'),
              onChanged: (value) => flight.departure = value,
            ),
            TextField(
              controller: TextEditingController(text: flight.destination),
              decoration: InputDecoration(labelText: 'Destination'),
              onChanged: (value) => flight.destination = value,
            ),
            TextField(
              controller: TextEditingController(text: flight.date),
              decoration: InputDecoration(labelText: 'Date'),
              onChanged: (value) => flight.date = value,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {});
            },
            child: Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: flights.length,
                itemBuilder: (context, index) {
                  final flight = flights[index];
                  return ListTile(
                    title: Text(flight.flightNumber),
                    subtitle: Text('${flight.departure} -> ${flight.destination}'),
                    trailing: IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () => _editFlight(index),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: _logout,
              child: Text('Log Out'),
            ),
          ],
        ),
      ),
    );
  }
}
