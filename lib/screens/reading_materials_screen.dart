import 'package:flutter/material.dart';
import 'package:paragliding_training/generated_localizations/app_localizations.dart';

class ReadingMaterialsScreen extends StatelessWidget {
  const ReadingMaterialsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final materials = [
      {'title': 'Paragliding Safety Manual', 'type': 'PDF', 'pages': '45'},
      {'title': 'Weather Conditions Guide', 'type': 'PDF', 'pages': '32'},
      {'title': 'Equipment Maintenance', 'type': 'Article', 'pages': '12'},
      {'title': 'Flight Regulations', 'type': 'PDF', 'pages': '28'},
      {'title': 'Emergency Procedures', 'type': 'Article', 'pages': '15'},
      {'title': 'Advanced Techniques', 'type': 'PDF', 'pages': '67'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Icon(Icons.paragliding, size: 32, color: Colors.white),
            const SizedBox(width: 12),
            Text(AppLocalizations.of(context)!.readingMaterials),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: materials.length,
        itemBuilder: (context, index) {
          final material = materials[index];
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: ListTile(
              leading: Icon(
                material['type'] == 'PDF' ? Icons.picture_as_pdf : Icons.article,
                color: Colors.black,
                size: 32,
              ),
              title: Text(material['title']!),
              subtitle: Text('${material['type']} • ${material['pages']} pages'),
              trailing: const Icon(Icons.download),
              onTap: () {
                // Open reading material
              },
            ),
          );
        },
      ),
    );
  }
}
