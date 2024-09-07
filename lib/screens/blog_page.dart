import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../services/blog_service.dart';
import '../widgets/blog_post_card.dart';

class BlogPage extends StatefulWidget {
  const BlogPage({super.key});

  @override
  State<BlogPage> createState() => _BlogPageState();
}

class _BlogPageState extends State<BlogPage> {
  final BlogService blogService = BlogService();
  late Future<List<BlogPost>> _futurePosts; // For asynchronous loading of posts

  @override
  void initState() {
    super.initState();
    _futurePosts =
        blogService.getAllPosts(); // Fetch the posts from the service
  }

  // Method to refresh the blog posts
  Future<void> _refreshPosts() async {
    setState(() {
      _futurePosts =
          blogService.getAllPosts(); // Refresh the posts from the service
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Blog'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.purple, Colors.deepPurpleAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: RefreshIndicator(
          onRefresh: _refreshPosts, // Define the refresh action
          color: Colors.white,
          backgroundColor: Colors.deepPurpleAccent,
          child: FutureBuilder<List<BlogPost>>(
            future: _futurePosts,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                ); // Loading indicator
              } else if (snapshot.hasError) {
                return const Center(
                  child: Text(
                    'Error loading blog posts',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ); // Error message
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(
                  child: Text(
                    'No blog posts available',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ); // No data message
              }

              final List<BlogPost> posts = snapshot.data!;

              return ListView.builder(
                padding:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return BlogPostCard(post: posts[index]);
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/new-blog-post');
        },
        backgroundColor: Colors.white,
        elevation: 5,
        child: const Icon(Icons.add, size: 30),
      ),
    );
  }
}
