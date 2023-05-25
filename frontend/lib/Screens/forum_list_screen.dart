import 'package:flutter/material.dart';
import 'package:frontend/models/forum.dart';
import 'package:frontend/services/api_service.dart';
import 'package:frontend/widgets/forum_card.dart';

class ForumListScreen extends StatefulWidget {
  ForumListScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ForumListScreenState createState() => _ForumListScreenState();
}

class _ForumListScreenState extends State<ForumListScreen> {
  late Future<List<Forum>> _forumList;

  @override
  void initState() {
    super.initState();
    _forumList = APIService().getForums();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forums'),
      ),
      body: FutureBuilder(
        future: _forumList,
        builder: (BuildContext context, AsyncSnapshot<List<Forum>> snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (BuildContext context, int index) {
                return ForumCard(snapshot.data![index]);
              },
            );
          } else {
            return const CircularProgressIndicator();
          }
        },
      ),
    );
  }
}
