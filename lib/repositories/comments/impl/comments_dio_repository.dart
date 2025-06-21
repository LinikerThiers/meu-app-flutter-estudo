import 'package:trilhaapp/model/comment_model.dart';
import 'package:trilhaapp/repositories/comments/comments_repository.dart';
import 'package:trilhaapp/repositories/jsonplaceholder_custom_dio.dart';

class CommentsDioRepository implements CommentsRepository {

  final JsonPlaceholderCustomDio _jsonPlaceholderCustomDio;
  CommentsDioRepository(this._jsonPlaceholderCustomDio);

  @override
  Future<List<CommentModel>> retornaComentarios(int postId) async {
    var response =
        await _jsonPlaceholderCustomDio.dio.get("/posts/$postId/comments");
    if (response.statusCode == 200) {
      return (response.data as List)
          .map((e) => CommentModel.fromJson(e))
          .toList();
    } else {
      return [];
    }
  }
}
