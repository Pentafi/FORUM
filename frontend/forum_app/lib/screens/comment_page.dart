import 'package:flutter/material.dart';
import 'package:forum_app/models/topic.dart';
import 'package:forum_app/models/comment.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CommentsPage extends StatefulWidget {
  final Topic topic;

  const CommentsPage({Key? key, required this.topic}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  Future<List<Comment>> fetchComments() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/comments/'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body) as List;
      List<Comment> comments = jsonData
          .map((json) => Comment.fromJson(json))
          .where((comment) => comment.topic == widget.topic.id) // filter comments by topic id
          .toList();
      return comments;
    } else {
      throw Exception('Failed to load comments');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.topic.title} Comments'),
      ),
      body: FutureBuilder<List<Comment>>(
        future: fetchComments(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].content),
                  // More information about the comment can be added here
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
          // Navigate to a new page to create a comment
        },
        tooltip: 'Add comment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
