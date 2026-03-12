import 'package:flutter/material.dart';
import 'package:app_flutter_rest/models/character.dart';

class CharacterCard extends StatelessWidget {
  final Character character;

  const CharacterCard({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(character.image),
        ),
        title: Text(character.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text('\${character.species} - \${character.status}'),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Clicked \${character.name}')),
          );
        },
      ),
    );
  }
}
