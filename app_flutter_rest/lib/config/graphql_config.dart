import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:app_flutter_rest/config/constants.dart';

class GraphQLConfiguration {
  static final HttpLink httpLink = HttpLink(AppConstants.graphQlEndpoint);

  static ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(store: InMemoryStore()),
    ),
  );

  static GraphQLClient clientToQuery() {
    return GraphQLClient(
      cache: GraphQLCache(store: InMemoryStore()),
      link: httpLink,
    );
  }
}
