import 'package:flutter/material.dart';
import 'package:frontend/Screens/topic_list_screen.dart';
import 'package:frontend/models/forum.dart';

class ForumCard extends StatelessWidget {
  final Forum forum;

  const ForumCard(this.forum, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              forum.name,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              'Created at: ${forum.date}',
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 5),
            TextButton(
              onPressed: () {
                // Navigate to the topic list screen
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TopicListScreen(forumId: forum.id)),
                );
              },
              child: Text(
                'View Details',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
