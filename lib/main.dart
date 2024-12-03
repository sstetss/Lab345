import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lab3_new_app/repositories/user_repository.dart';
import 'package:lab3_new_app/services/network_service.dart'; // Додаємо NetworkService
import 'package:lab3_new_app/screens/home_screen.dart';
import 'package:lab3_new_app/screens/login_screen.dart';
import 'package:lab3_new_app/screens/registration_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Flights',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: FutureBuilder<SharedPreferences>(
        future: SharedPreferences.getInstance(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Scaffold(
              body: Center(child: CircularProgressIndicator()), // Показуємо спинер під час завантаження SharedPreferences
            );
          }

          if (snapshot.hasError) {
            return Scaffold(
              body: Center(child: Text('Error loading preferences')),
            );
          }

          final prefs = snapshot.data;

          return MultiProvider(
            providers: [
              // Додаємо провайдери
              Provider(create: (_) => UserRepository(prefs!)),
              Provider(create: (_) => NetworkService()), // Додаємо NetworkService
            ],
            child: MaterialApp(
              title: 'Flutter Flights',
              theme: ThemeData(primarySwatch: Colors.blue),
              home: LoginScreen(), // Початковий екран
              routes: {
                '/register': (context) => RegistrationScreen(
                  userRepository: Provider.of<UserRepository>(context, listen: false), // Передаємо UserRepository на екран реєстрації
                ),
              },
            ),
          );
        },
      ),
    );
  }
}
