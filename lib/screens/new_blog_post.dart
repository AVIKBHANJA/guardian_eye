import 'package:flutter/material.dart';
import '../models/blog_post.dart';
import '../services/blog_service.dart';

class NewBlogPostPage extends StatelessWidget {
  final BlogService blogService;
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();

  NewBlogPostPage({super.key, required this.blogService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Blog Post'),
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildTextField(titleController, 'Title', Icons.title),
            const SizedBox(height: 20),
            _buildTextField(contentController, 'Content', Icons.description,
                maxLines: 10),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                // Validate the input fields before submitting
                if (titleController.text.isEmpty ||
                    contentController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Please fill in both title and content')),
                  );
                  return;
                }

                final newPost = BlogPost(
                  title: titleController.text,
                  content: contentController.text,
                );

                blogService.addPost(newPost).then((_) {
                  // Show success message and pop the page
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Blog post added successfully')),
                  );
                  Navigator.pop(context);
                }).catchError((error) {
                  // Handle any errors that occur during post submission
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Failed to add blog post: $error')),
                  );
                });
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.deepPurpleAccent,
                padding: const EdgeInsets.symmetric(vertical: 15),
                textStyle: const TextStyle(fontSize: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
                elevation: 5,
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.send),
                  SizedBox(width: 10),
                  Text('Submit'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller, String label, IconData icon,
      {int maxLines = 1}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.deepPurpleAccent),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.deepPurpleAccent),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide:
              const BorderSide(color: Colors.deepPurpleAccent, width: 2),
        ),
        filled: true,
        fillColor: Colors.white.withOpacity(0.9),
      ),
    );
  }
}
