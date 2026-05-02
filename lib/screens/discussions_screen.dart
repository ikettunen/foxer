import 'package:flutter/material.dart';
import 'package:paragliding_training/generated_localizations/app_localizations.dart';

class DiscussionsScreen extends StatelessWidget {
  const DiscussionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discussions = [
      {'title': 'Best flight sites in Europe?', 'author': 'John D.', 'replies': '12', 'time': '2h ago'},
      {'title': 'Tips for first solo flight', 'author': 'Sarah M.', 'replies': '8', 'time': '5h ago'},
      {'title': 'Equipment recommendations', 'author': 'Mike R.', 'replies': '15', 'time': '1d ago'},
      {'title': 'Weather conditions today', 'author': 'Anna K.', 'replies': '4', 'time': '3h ago'},
      {'title': 'Safety incident report', 'author': 'Tom B.', 'replies': '23', 'time': '2d ago'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.paragliding, size: 32, color: Colors.white),
            const SizedBox(width: 12),
            Text(AppLocalizations.of(context)!.discussions),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Create new discussion
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: discussions.length,
        itemBuilder: (context, index) {
          final discussion = discussions[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: const CircleAvatar(
                child: Icon(Icons.person),
              ),
              title: Text(discussion['title']!),
              subtitle: Text('${discussion['author']} • ${discussion['time']}'),
              trailing: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.comment, size: 20),
                  Text(discussion['replies']!),
                ],
              ),
              onTap: () {
                // Open discussion detail
              },
            ),
          );
        },
      ),
    );
  }
}
