import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PostDetailScreen extends StatelessWidget {
  final String postId;

  const PostDetailScreen({super.key, required this.postId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Post $postId')),
      body: Center(
        child: Text('Under Construction', style: context.textTheme.headlineMedium?.copyWith(color: context.theme.disabledColor)),
      ),
    );
  }
}
