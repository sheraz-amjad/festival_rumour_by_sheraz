import 'package:flutter/material.dart';

class LeaderboardTile extends StatelessWidget {
  final Map<String, dynamic> data;

  const LeaderboardTile({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        leading: Text('${data['rank']}', style: const TextStyle(fontWeight: FontWeight.bold)),
        title: Text(data['name']),
        trailing: Text('${data['points']} pts'),
      ),
    );
  }
}
