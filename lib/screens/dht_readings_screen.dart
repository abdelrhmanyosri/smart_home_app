import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class DHTReadingsScreen extends StatefulWidget {
  @override
  _DHTReadingsScreenState createState() => _DHTReadingsScreenState();
}

class _DHTReadingsScreenState extends State<DHTReadingsScreen> {
  final DatabaseReference _dhtRef = FirebaseDatabase.instance.ref('DHT');

  Map<String, dynamic> dhtData = {};

  @override
  void initState() {
    super.initState();
    _dhtRef.onValue.listen((event) {
      setState(() {
        dhtData = Map<String, dynamic>.from(event.snapshot.value as Map);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('DHT Readings')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSensorCard('Temperature', '${dhtData['temperature']} °C'),
            _buildSensorCard('Humidity', '${dhtData['humidity']} %'),
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
