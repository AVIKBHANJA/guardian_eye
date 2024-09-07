import 'package:cloud_firestore/cloud_firestore.dart';

class BlogPost {
  // final String id;
  final String title;
  final String content;
  // final DateTime date; // Add the 'date' variable

  BlogPost({
    // required this.id,
    required this.title,
    required this.content,
    // required this.date, // Add the 'date' parameter
  });

  // Factory method to create a BlogPost from Firestore document
  factory BlogPost.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    return BlogPost(
      // id: doc.id,
      title: data['title'] ?? '',
      content: data['content'] ?? '',
      // date: (data['date'] as Timestamp).toDate(), // Assign the 'date' value
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'content': content,
      // 'date': date.toIso8601String(), // Convert DateTime to a string
    };
  }
}
