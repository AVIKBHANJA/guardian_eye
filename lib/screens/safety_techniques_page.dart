import 'package:flutter/material.dart';

class SafetyTechniquesPage extends StatelessWidget {
  final List<Map<String, String>> safetyTips = [
    {
      'title': 'Stay Aware of Your Surroundings',
      'description':
          'Always be aware of your surroundings. Avoid distractions like using your phone while walking and be mindful of people around you.',
    },
    {
      'title': 'Trust Your Instincts',
      'description':
          'If you feel uncomfortable or sense danger, trust your instincts and leave the area immediately. It’s better to be safe than sorry.',
    },
    {
      'title': 'Know Basic Self-Defense Moves',
      'description':
          'Learn a few basic self-defense moves. For instance, using your keys as a weapon, aiming for the attacker\'s sensitive areas, and practicing defensive postures.',
    },
    {
      'title': 'Use Personal Safety Apps',
      'description':
          'Download and use personal safety apps (like GuardianEye) to quickly alert friends, family, or local authorities in case of an emergency.',
    },
    {
      'title': 'Create a Safe Word',
      'description':
          'Create a safe word with trusted contacts. Use this word to communicate quickly in situations where you might not be able to speak freely.',
    },
    {
      'title': 'Carry a Personal Alarm',
      'description':
          'Carry a personal alarm to deter attackers. A loud noise can attract attention and scare away potential threats.',
    },
    {
      'title': 'Know Emergency Numbers',
      'description':
          'Keep a list of emergency numbers saved in your phone and memorize important contacts. This can help you reach out quickly during emergencies.',
    },
    {
      'title': 'Stay in Well-Lit Areas',
      'description':
          'When walking alone, choose well-lit paths and avoid isolated areas. Stay close to populated areas whenever possible.',
    },
  ];

   SafetyTechniquesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('Safety Techniques'),
        backgroundColor: Colors.purple,
      ),
      body: Padding(
        padding:const EdgeInsets.all(16.0),
        child: ListView.builder(
          itemCount: safetyTips.length,
          itemBuilder: (context, index) {
            return Card(
              margin:const EdgeInsets.only(bottom: 16.0),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5,
              child: ListTile(
                contentPadding:const EdgeInsets.all(16.0),
                title: Text(
                  safetyTips[index]['title']!,
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  safetyTips[index]['description']!,
                  style:const TextStyle(fontSize: 16.0),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
