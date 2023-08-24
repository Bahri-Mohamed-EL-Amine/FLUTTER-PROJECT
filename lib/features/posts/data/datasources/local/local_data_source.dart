import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_clean_architecture_posts_app/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/post_model.dart';

abstract class LocalDataSource {
  Future<List<PostModel>> getCashedPosts();
  Future<Unit> cashePosts(List<PostModel> postsModels);
}

class LocalDataSourceImpl extends LocalDataSource {
  final SharedPreferences sharedPreferences;
  LocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> cashePosts(List<PostModel> postsModels) {
    final jsons = postsModels.map((e) => e.toJson()).toList();
    final jsonString = json.encode(jsons);
    sharedPreferences.setString('CASHED_POSTS', jsonString);
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPosts() {
    final jsonString = sharedPreferences.getString('CASHED_POSTS');
    if (jsonString != null) {
      final List jsonList = json.decode(jsonString) as List;
      final posts = jsonList.map((e) => PostModel.fromJson(e)).toList();
      return Future.value(posts);
    } else {
      throw EmptyCasheException();
    }
  }
}
