import 'package:flutter/material.dart';
import '../repositories/user_repository.dart';
import '../utils/validators.dart';

class RegistrationScreen extends StatefulWidget {
  final UserRepository userRepository;

  const RegistrationScreen({Key? key, required this.userRepository}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  String? _errorMessage;

  void _register() async {
    final email = _emailController.text;
    final password = _passwordController.text;
    final name = _nameController.text;

    if (!isValidEmail(email)) {
      setState(() => _errorMessage = 'Invalid email address');
      return;
    }
    if (!isValidPassword(password)) {
      setState(() => _errorMessage = 'Password must be at least 6 characters');
      return;
    }
    if (!isValidName(name)) {
      setState(() => _errorMessage = 'Name must not contain numbers or special characters');
      return;
    }

    await widget.userRepository.registerUser(email, password, name);

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registration')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            if (_errorMessage != null) Text(_errorMessage!, style: TextStyle(color: Colors.red)),
            SizedBox(height: 16),
            ElevatedButton(onPressed: _register, child: Text('Register')),
          ],
        ),
      ),
    );
  }
}
