import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum Timezone { WIB, WITA, WIT, London }

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime _time = DateTime.now();
  Timezone _selectedTimezone = Timezone.WIB;

  String _formatTime(DateTime time) {
    switch (_selectedTimezone) {
      case Timezone.WIB:
        return DateFormat('HH:mm').format(time);
      case Timezone.WITA:
        return DateFormat('HH:mm').format(time.subtract(Duration(hours: 1)));
      case Timezone.WIT:
        return DateFormat('HH:mm').format(time.subtract(Duration(hours: 2)));
      case Timezone.London:
        return DateFormat('HH:mm').format(time.toUtc());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'image/Batman.jpg',
              width: 200,
              height: 200,
            ),
            SizedBox(height: 20),
            Text(
              'Damario Denny / 123210110',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.access_time),
                SizedBox(width: 10),
                Text(
                  _formatTime(_time),
                  style: TextStyle(fontSize: 24),
                ),
                SizedBox(width: 20),
                DropdownButton<Timezone>(
                  value: _selectedTimezone,
                  onChanged: (Timezone? newValue) {
                    if (newValue != null) {
                      setState(() {
                        _selectedTimezone = newValue;
                      });
                    }
                  },
                  items: Timezone.values
                      .map<DropdownMenuItem<Timezone>>((Timezone value) {
                    return DropdownMenuItem<Timezone>(
                      value: value,
                      child: Text(_timezoneToString(value)),
                    );
                  }).toList(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _timezoneToString(Timezone timezone) {
    switch (timezone) {
      case Timezone.WIB:
        return 'WIB';
      case Timezone.WITA:
        return 'WITA';
      case Timezone.WIT:
        return 'WIT';
      case Timezone.London:
        return 'London';
    }
  }
}
