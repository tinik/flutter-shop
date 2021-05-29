import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';

final _queryProduct = gql(r'''
query {
  storeConfig {
    base_media_url
    root_category_id
  }
}
''');

Future<dynamic> getStoreConfig() async {
  final client = getClient();

  final QueryResult result = await client.query(QueryOptions(
    errorPolicy: ErrorPolicy.ignore,
    fetchPolicy: FetchPolicy.cacheFirst,
    document: _queryProduct,
  ));

  final dynamic data = result.data!['storeConfig'];
  return data;
}
