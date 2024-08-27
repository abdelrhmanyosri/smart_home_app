import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class ControlsScreen extends StatefulWidget {
  @override
  _ControlsScreenState createState() => _ControlsScreenState();
}

class _ControlsScreenState extends State<ControlsScreen> {
  final DatabaseReference _garageRef = FirebaseDatabase.instance.ref('Control/garage');
  final DatabaseReference _windowRef = FirebaseDatabase.instance.ref('Control/window');
  final DatabaseReference _doorRef = FirebaseDatabase.instance.ref('Control/door');

  String _garageStatus = 'Loading...';
  String _windowStatus = 'Loading...';
  String _doorStatus = 'Loading...';

  @override
  void initState() {
    super.initState();
    _garageRef.onValue.listen((event) {
      setState(() {
        _garageStatus = event.snapshot.value.toString();
      });
    });

    _windowRef.onValue.listen((event) {
      setState(() {
        _windowStatus = event.snapshot.value.toString();
      });
    });

    _doorRef.onValue.listen((event) {
      setState(() {
        _doorStatus = event.snapshot.value.toString();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Controls')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildControlCard('Garage Door', _garageStatus),
            SizedBox(height: 20),
            _buildControlCard('Window', _windowStatus),
            SizedBox(height: 20),
            _buildControlCard('Main Door', _doorStatus),
          ],
        ),
      ),
    );
  }

  Widget _buildControlCard(String title, String status) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            SizedBox(height: 20),
            Text(
              'Status: $status',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
