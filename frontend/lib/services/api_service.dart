import 'dart:convert';
import 'package:frontend/models/comment.dart';
import 'package:frontend/models/forum.dart';
import 'package:frontend/models/topic.dart';
import 'package:http/http.dart' as http;

class APIService {
  final String _baseUrl = "http://127.0.0.1:8000";

  Future<List<Forum>> getForums() async {
    final response = await http.get(Uri.parse('$_baseUrl/api/forums/'));

    if (response.statusCode == 200) {
      final List<dynamic> forumJson = json.decode(response.body);
      return forumJson.map((json) => Forum.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load forums');
    }
  }

  Future<Forum> getForum(int id) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/forums/$id'));

    if (response.statusCode == 200) {
      return Forum.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load forum');
    }
  }

  Future<List<Topic>> getTopics(int forumId) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/forums/$forumId/topics'));

    if (response.statusCode == 200) {
      final List<dynamic> topicJson = json.decode(response.body);
      return topicJson.map((json) => Topic.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load topics');
    }
  }

  Future<Topic> getTopic(int topicId) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/topics/$topicId'));

    if (response.statusCode == 200) {
      return Topic.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load topic');
    }
  }

  Future<List<Comment>> getComments(int topicId) async {
    final response = await http.get(Uri.parse('$_baseUrl/api/topics/$topicId/comments'));

    if (response.statusCode == 200) {
      final List<dynamic> commentJson = json.decode(response.body);
      return commentJson.map((json) => Comment.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load comments');
    }
  }
}
