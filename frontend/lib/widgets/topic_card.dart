import 'package:flutter/material.dart';
import 'package:frontend/models/topic.dart';

class TopicCard extends StatelessWidget {
  final Topic topic;

  const TopicCard(this.topic, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(topic.title),  // Use 'title' instead of 'name'
        subtitle: Text('Date: ${topic.date}'),
        onTap: () {
          // Navigate to the TopicDetailScreen or whatever action you'd like to take
        },
      ),
    );
  }
}
