import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/repositories/posts/posts_repository.dart';
import 'package:dio/dio.dart';

class PostsDioRepository implements PostsRepository {
  @override
  Future<List<PostModel>> obterPosts() async {
    var dio = Dio();
    var response = await dio.get("https://jsonplaceholder.typicode.com/posts");
    if (response.statusCode == 200) {
      return (response.data as List).map((e) => PostModel.fromJson(e)).toList();
    } else {
      return [];
    }
  }
}
