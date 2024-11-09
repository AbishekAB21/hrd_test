import 'package:flutter/material.dart';
import 'package:hrd_test/models/model.dart';
import 'package:hrd_test/utils/app_colors.dart';
import 'package:hrd_test/utils/fontstyles.dart';
import 'package:provider/provider.dart';
import '../provider/home_screen_provider.dart';

class PostListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appcolor.backgroundColor,
      appBar: AppBar(
        backgroundColor: appcolor.backgroundColor,
        centerTitle: true,
        title: Text(
          'Posts',
          style: Fontstyles.HeadlineStyle1(context),
        ),
      ),
      body: Consumer<PostProvider>(
        builder: (context, provider, child) {
          if (provider.posts.isEmpty) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: provider.posts.length,
            itemBuilder: (ctx, index) {
              final Post post = provider.posts[index];
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: appcolor.successColor,
                  child: Text(
                    post.id.toString(),
                    style: Fontstyles.ButtonText1(context),
                  ),
                ),
                title: Text(
                  post.title,
                  style: Fontstyles.HeadlineStyle2(context),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  post.body,
                  style: Fontstyles.ContentTextStyle(context),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
              );
            },
          );
        },
      ),
    );
  }
}
