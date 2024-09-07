import 'package:flutter/material.dart';
import '../models/blog_post.dart';

class BlogPostCard extends StatelessWidget {
  final BlogPost post;

  const BlogPostCard({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(post.title,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(post.content, maxLines: 3, overflow: TextOverflow.ellipsis),
            const SizedBox(height: 10),
            // Text('Posted on: ${post.date.toLocal()}'),
          ],
        ),
      ),
    );
  }
}
