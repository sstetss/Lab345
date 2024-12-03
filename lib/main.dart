import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lab3_new_app/repositories/user_repository.dart';
import 'package:lab3_new_app/screens/login_screen.dart';
import 'package:lab3_new_app/screens/home_screen.dart';
import 'package:lab3_new_app/services/network_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final sharedPreferences = await SharedPreferences.getInstance();
  final userRepository = UserRepository(sharedPreferences);
  runApp(MyApp(userRepository: userRepository));
}

class MyApp extends StatelessWidget {
  final UserRepository userRepository;

  const MyApp({Key? key, required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<UserRepository>.value(value: userRepository),
        Provider<NetworkService>(
          create: (_) => NetworkService(),
        ),
      ],
      child: MaterialApp(
        home: FutureBuilder<bool>(
          future: userRepository.isLoggedIn(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            final isLoggedIn = snapshot.data ?? false;
            return isLoggedIn ? HomeScreen() : LoginScreen();
          },
        ),
      ),
    );
  }
}
