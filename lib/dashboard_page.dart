import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Smart Home Dashboard'),
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16.0),
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        children: [
          _buildTile(Icons.thermostat, 'Temperature', '22°C'),
          _buildTile(Icons.lightbulb, 'Lights', 'On'),
          _buildTile(Icons.lock, 'Doors', 'Locked'),
          _buildTile(Icons.wifi, 'Wi-Fi', 'Connected'),
        ],
      ),
    );
  }

  Widget _buildTile(IconData icon, String title, String status) {
    return Card(
      elevation: 4,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 40),
          const SizedBox(height: 8),
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 4),
          Text(status, style: const TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
