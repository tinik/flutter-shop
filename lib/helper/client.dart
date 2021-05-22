import 'package:graphql/client.dart';

GraphQLClient getClient() {
  final Link _link = HttpLink(
    'https://venia.magento.com/graphql/',
    useGETForQueries: true,
    defaultHeaders: {
      "store": "default"
    },
  );



  return GraphQLClient(
    /// pass the store to the cache for persistence
    cache: GraphQLCache(),
    link: _link,
  );
}
