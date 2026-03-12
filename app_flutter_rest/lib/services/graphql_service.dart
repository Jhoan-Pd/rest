import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app_flutter_rest/config/graphql_config.dart';
import 'package:app_flutter_rest/models/character.dart';

class GraphQLService {
  Future<List<Character>> getCharacters({int page = 1}) async {
    const String query = '''
      query GetCharacters(\$page: Int) {
        characters(page: \$page) {
          results {
            id
            name
            status
            species
            type
            gender
            image
          }
        }
      }
    ''';

    try {
      final client = GraphQLConfiguration.clientToQuery();
      final QueryResult result = await client.query(
        QueryOptions(
          document: gql(query),
          variables: {'page': page},
          fetchPolicy: FetchPolicy.networkOnly,
        ),
      );

      if (result.hasException) {
        throw Exception('Error GraphQL: \${result.exception.toString()}');
      }

      if (result.data != null && result.data!['characters'] != null) {
        final List<dynamic> results = result.data!['characters']['results'];
        return results.map((json) => Character.fromJson(json)).toList();
      }

      return [];
    } catch (e) {
      throw Exception('Error fetching characters via GraphQL: \$e');
    }
  }
}
