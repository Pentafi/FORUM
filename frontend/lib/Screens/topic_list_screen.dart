import 'package:flutter/material.dart';
import 'package:frontend/models/topic.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/topic_card.dart';

class TopicListScreen extends StatefulWidget {
  final int forumId;

  const TopicListScreen({super.key, required this.forumId});

  @override
  // ignore: library_private_types_in_public_api
  _TopicListScreenState createState() => _TopicListScreenState();
}

class _TopicListScreenState extends State<TopicListScreen> {
  late Future<List<Topic>> _topicList;

  @override
  void initState() {
    super.initState();
    _topicList = APIService().getTopics(widget.forumId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Topics'),
      ),
      body: FutureBuilder(
        future: _topicList,
        builder: (BuildContext context, AsyncSnapshot<List<Topic>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return TopicCard(snapshot.data![index]);
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error}"),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
