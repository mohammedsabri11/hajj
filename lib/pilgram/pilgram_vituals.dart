import 'package:flutter/material.dart';

class HealthVitulsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('الموشرات الصحية'),
          backgroundColor: Colors.green,
        ),
        body: HealthVitulsList());
  }
}

class HealthVitulsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: [
        HealthIndicatorCard(
          title: 'معدل النبض',
          value: '72 bpm',
          icon: Icons.favorite,
          color: Colors.red,
        ),
        SizedBox(height: 16.0),
        HealthIndicatorCard(
          title: 'ضغط الدم',
          value: '120/80 mmHg',
          icon: Icons.healing,
          color: Colors.blue,
        ),
        SizedBox(height: 16.0),
        HealthIndicatorCard(
          title: 'تشبع الاكسجين ',
          value: '96,5 ',
          icon: Icons.directions_walk,
          color: Colors.green,
        ),
        SizedBox(height: 16.0),
        HealthIndicatorCard(
          title: 'درجة الحرارة',
          value: '35,5 C',
          icon: Icons.directions_walk,
          color: Colors.green,
        ),
      ],
    );
  }
}

class HealthIndicatorCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;
  final Color color;

  const HealthIndicatorCard({
    required this.title,
    required this.value,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(
              icon,
              color: color,
              size: 32.0,
            ),
            SizedBox(width: 16.0),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  value,
                  style: TextStyle(
                    fontSize: 16.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
