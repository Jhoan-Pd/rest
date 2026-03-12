import 'package:flutter/material.dart';
import 'package:app_flutter_rest/models/character.dart';
import 'package:app_flutter_rest/services/graphql_service.dart';
import 'package:app_flutter_rest/widgets/error_message.dart';
import 'package:app_flutter_rest/widgets/character_card.dart';

class CharacterListScreen extends StatefulWidget {
  const CharacterListScreen({super.key});

  @override
  State<CharacterListScreen> createState() => _CharacterListScreenState();
}

class _CharacterListScreenState extends State<CharacterListScreen> {
  final GraphQLService _graphQLService = GraphQLService();
  late Future<List<Character>> _charactersFuture;

  @override
  void initState() {
    super.initState();
    _loadCharacters();
  }

  void _loadCharacters() {
    setState(() {
      _charactersFuture = _graphQLService.getCharacters();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GraphQL Characters')),
      body: FutureBuilder<List<Character>>(
        future: _charactersFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return ErrorMessage(
              message: 'Failed to load characters: \${snapshot.error}',
              onRetry: _loadCharacters,
            );
          } else if (snapshot.hasData && snapshot.data!.isEmpty) {
            return const Center(child: Text('No characters found'));
          } else if (snapshot.hasData) {
            return RefreshIndicator(
              onRefresh: () async {
                _loadCharacters();
              },
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return CharacterCard(character: snapshot.data![index]);
                },
              ),
            );
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
