import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';

class _Options {
  final String label, value;

  _Options({
    required this.label,
    required this.value,
  });
}

class Aggregation {
  final int count;
  final String code, label;
  final List<_Options> options;

  Aggregation({
    required this.code,
    required this.label,
    required this.count,
    required this.options,
  });
}

Aggregation _setAggregations(dynamic row) {
  final List<_Options> options = [];
  row['options'].forEach((row) => options.add(_Options(
        label: row['label'].toString(),
        value: row['value'].toString(),
      )));

  return Aggregation(
    code: row['code'],
    label: row['label'],
    count: int.parse(row['count'].toString()),
    options: options,
  );
}

final _queryAggregations = gql(r'''
  query getProductsFiltersByCategory($filters: ProductAttributeFilterInput!) {
    products (filter: $filters) {
      aggregations {
        code: attribute_code
        label 
        count  
        options {
          label 
          value
        }
      }  
    }
  } 
''');

Future<List<dynamic>> getAggregations(Map<String, dynamic> filters) async {
  final client = getClient();

  final QueryResult result = await client.query(QueryOptions(
    fetchPolicy: FetchPolicy.cacheFirst,
    document: _queryAggregations,
    variables: {
      "filters": filters,
    },
  ));

  if (result.hasException) {
    print(result.exception);
  }

  final aggregations = [];
  if (!result.isLoading && null != result.data) {
    final dynamic data = result.data!['products'];
    data['aggregations'].forEach((row) {
      if (!row['code'].toString().startsWith('category')) {
        aggregations.add(_setAggregations(row));
      }
    });
  }

  return aggregations;
}
