import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class SensorReadingsScreen extends StatefulWidget {
  @override
  _SensorReadingsScreenState createState() => _SensorReadingsScreenState();
}

class _SensorReadingsScreenState extends State<SensorReadingsScreen> {
  final DatabaseReference _sensorRef = FirebaseDatabase.instance.ref('Sensor');

  Map<String, dynamic> sensorData = {};

  @override
  void initState() {
    super.initState();
    _sensorRef.onValue.listen((event) {
      setState(() {
        sensorData = Map<String, dynamic>.from(event.snapshot.value as Map);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sensor Readings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSensorCard('Gas', sensorData['gas']),
            _buildSensorCard('Flame', sensorData['flame']),
            _buildSensorCard('IR', sensorData['ir']),
            _buildSensorCard('Rain', sensorData['rain']),
          ],
        ),
      ),
    );
  }

  Widget _buildSensorCard(String title, dynamic value) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text(value != null ? '$value' : 'Loading...', style: TextStyle(fontSize: 16)),
      ),
    );
  }
}

