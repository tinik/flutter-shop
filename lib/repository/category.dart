import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';

class Category {
  final int id;
  final String name;
  final List<Category> children;

  Category({
    required this.id,
    required this.name,
    required this.children,
  });
}

Category setPrepareCategory(dynamic row) {
  final List<Category> values = [];
  try {
    final bool isMore = (row.children.length > 0) ?? false;
    if (isMore) {
      row['children'].forEach((row) => values.add(setPrepareCategory(row)));
    }
  } catch (err) {
    // ignore all exception
  }

  return Category(
    id: row['id'],
    name: row['name'],
    children: values,
  );
}

final _queryCategory = gql(r'''
query getCategoy($id: Int!) {
  category(id: $id) {
    id
    name
    description   
    children {
      id
      name
    }
  }
}
''');

Future<Category> getCategory(int id) async {
  // Function filter = row => row.isMenu === true;
  final client = getClient();

  final QueryResult result = await client.query(QueryOptions(
    errorPolicy: ErrorPolicy.ignore,
    fetchPolicy: FetchPolicy.cacheFirst,
    document: _queryCategory,
    variables: {
      "id": id,
    },
  ));

  final dynamic data = result.data!['category'];
  final bool isMore = data['children']!.length > 0;

  final List<Category> values = [];
  if (isMore) {
    data['children'].forEach((row) => values.add(setPrepareCategory(row)));
  }

  return Category(
    id: data['id'],
    name: data['name'],
    children: values,
  );
}
