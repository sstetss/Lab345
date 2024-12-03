import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';

class HomeScreen extends StatefulWidget {
  final UserRepository userRepository;

  const HomeScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Map<String, String>> _userData;

  @override
  void initState() {
    super.initState();
    _userData = widget.userRepository.getUserData();
  }

  void _logout() async {
    await widget.userRepository.deleteUser();
    Navigator.pushReplacementNamed(context, '/login');
  }

  void _editData() async {
    // Простий приклад редагування імені
    await widget.userRepository.updateUserData({'name': 'Updated Name'});
    setState(() {
      _userData = widget.userRepository.getUserData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(onPressed: _logout, icon: Icon(Icons.logout)),
        ],
      ),
      body: FutureBuilder<Map<String, String>>(
        future: _userData,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading user data'));
          } else {
            final data = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Name: ${data['name']}'),
                  Text('Email: ${data['email']}'),
                  SizedBox(height: 16),
                  ElevatedButton(onPressed: _editData, child: Text('Edit Data')),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
