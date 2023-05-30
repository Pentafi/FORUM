import 'package:flutter/material.dart';
import 'package:forum_app/models/forum.dart';
import 'package:forum_app/screens/topic_page.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

class ForumPage extends StatefulWidget {
  const ForumPage({Key? key}) : super(key: key);

  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  Future<List<Forum>> fetchForums() async {
    final response = await http.get(Uri.parse('http://127.0.0.1:8000/api/forums/'));

    if (response.statusCode == 200) {
      var jsonData = jsonDecode(response.body) as List;
      List<Forum> forums = jsonData.map((json) => Forum.fromJson(json)).toList();
      return forums;
    } else {
      throw Exception('Failed to load forums');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forums'),
      ),
      body: FutureBuilder<List<Forum>>(
        future: fetchForums(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length ?? 0,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => TopicPage(forum: snapshot.data![index]),

                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          // By default, show a loading spinner.
          return const CircularProgressIndicator();
        },
      ),
    );
  }
}
