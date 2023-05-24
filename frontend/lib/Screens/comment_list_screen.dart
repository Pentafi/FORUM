import 'package:flutter/material.dart';
import 'package:frontend/models/comment.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/comment_card.dart';

class CommentListScreen extends StatefulWidget {
  final int topicId;

  const CommentListScreen({super.key, required this.topicId});

  @override
  // ignore: library_private_types_in_public_api
  _CommentListScreenState createState() => _CommentListScreenState();
}

class _CommentListScreenState extends State<CommentListScreen> {
  late Future<List<Comment>> _commentList;

  @override
  void initState() {
    super.initState();
    _commentList = APIService().getComments(widget.topicId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Comments'),
      ),
      body: FutureBuilder(
        future: _commentList,
        builder: (BuildContext context, AsyncSnapshot<List<Comment>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (BuildContext context, int index) {
                return CommentCard(snapshot.data![index]);
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
