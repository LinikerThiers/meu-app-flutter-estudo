import 'package:flutter/material.dart';
import 'package:trilhaapp/model/post_model.dart';
import 'package:trilhaapp/pages/comments_page.dart';
// import 'package:trilhaapp/repositories/posts/impl/posts_dio_repository.dart';
// import 'package:trilhaapp/repositories/posts/impl/posts_http_repository.dart';
import 'package:trilhaapp/repositories/posts/posts_repository.dart';

import '../main.dart';

class PostsPage extends StatefulWidget {
  const PostsPage({super.key});

  @override
  State<PostsPage> createState() => _PostsPageState();
}

class _PostsPageState extends State<PostsPage> {
  // PostsRepository postsRepository = PostsHttpRepository();
  var postsRepository = getIt<PostsRepository>();
  var posts = <PostModel>[];

  @override
  void initState() {
    super.initState(); 
    carregarDados();
  }

  carregarDados() async {
    posts = await postsRepository.obterPosts();
    setState(() {
      
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
          appBar: AppBar(
    title: Text("Posts"),
          ),
          body: ListView.builder(
      itemCount: posts.length,
      itemBuilder: (_, index) {
        var post = posts[index];
        return InkWell(
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CommentsPage(postId: post.id)));
          },
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Card(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      post.title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      post.body,
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
        );
  }
}
