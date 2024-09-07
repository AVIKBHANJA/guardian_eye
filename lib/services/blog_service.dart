import '../models/blog_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:developer' as devtools show log;

class BlogService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<BlogPost>> getAllPosts() async {
    try {
      QuerySnapshot snapshot = await _firestore.collection('blogPosts').get();

      devtools.log('Fetched ${snapshot.docs.length} blog posts');
      // Convert the data from Firestore to BlogPost model
      List<BlogPost> posts = snapshot.docs.map((doc) {
        return BlogPost.fromFirestore(doc);
      }).toList();

      return posts;
    } catch (e) {
      devtools.log('Error fetching blog posts: $e');
      throw Exception('Error fetching blog posts');
    }
  }

  Future<void> addPost(BlogPost post) async {
    try {
      await _firestore.collection('blogPosts').add(post.toMap());
    } catch (e) {
      throw Exception('Failed to add blog post: $e');
    }
  }
}
