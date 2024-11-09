import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hrd_test/database/db.dart';
import 'package:hrd_test/models/model.dart';
import 'package:http/http.dart' as http;

class PostProvider extends ChangeNotifier {
  List<Post> posts = [];

  PostProvider() {
    initializePosts();
  }

  Future<void> initializePosts() async {
    await fetchAndStorePosts();
    await loadPostsFromDB();
  }

  Future<void> fetchAndStorePosts() async {
    final url = 'https://jsonplaceholder.typicode.com/posts';
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body) as List;
        final fetchedPosts = data.map((item) => Post.fromJson(item)).toList();
        for (var post in fetchedPosts) {
          await DBHelper.insertPost(post);
        }
        print('Data fetched and stored successfully');
      } else {
        print('Failed to fetch data from API');
      }
    } catch (e) {
      print('Error fetching posts: $e');
    }
  }

  Future<void> loadPostsFromDB() async {
    try {
      posts = await DBHelper.getPosts();
      notifyListeners();
    } catch (e) {
      print('Error loading posts from DB: $e');
    }
  }
}
