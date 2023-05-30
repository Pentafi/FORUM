import 'package:flutter/material.dart';
import 'package:forum_app/models/forum.dart';
import 'package:forum_app/models/topic.dart';
import 'package:forum_app/screens/comment_page.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TopicPage extends StatefulWidget {
  final Forum forum;

  const TopicPage({Key? key, required this.forum}) : super(key: key);

  @override
  _TopicPageState createState() => _TopicPageState();
}

class _TopicPageState extends State<TopicPage> {
  Future<List<Topic>> fetchTopics() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/topics/'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body) as List;
      List<Topic> topics = jsonData
          .map((json) => Topic.fromJson(json))
          .where((topic) => topic.forum == widget.forum.id) // filter topics by forum id
          .toList();
      return topics;
    } else {
      throw Exception('Failed to load topics');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.forum.name} Topics'),
      ),
      body: FutureBuilder<List<Topic>>(
        future: fetchTopics(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].title),
                  onTap: () {
                    // Navigate to the comments page and pass the selected topic
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CommentsPage(topic: snapshot.data![index]),
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return const CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to a new page to create a topic
        },
        tooltip: 'Add topic',
        child: const Icon(Icons.add),
      ),
    );
  }
}
