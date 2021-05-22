import 'dart:core';

import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';

class Menu {
  final int id, isMenu, position;
  final String name;

  Menu({
    required this.id,
    required this.isMenu,
    required this.position,
    required this.name,
  });
}

Menu setPrepareMenu(dynamic row) {
  return Menu(
    id: row['id'],
    name: row['name'],
    isMenu: row['isMenu'],
    position: row['position'],
  );
}

final _queryNavigation = gql(r'''{
  menu: categoryList {
    id 
    name 
    children {
      id 
      name 
      position
      isMenu: include_in_menu 
    }
  }
}''');

Future<List<Menu>> getNavigation() async {
  final client = getClient();

  final QueryResult result = await client.query(QueryOptions(
    errorPolicy: ErrorPolicy.ignore,
    fetchPolicy: FetchPolicy.cacheFirst,
    document: _queryNavigation,
  ));

  if (!result.isLoading) {
    final List<dynamic> menu = result.data!['menu']![0]!['children'];
    return menu.where((dynamic row) => 1 == row['isMenu']).map(setPrepareMenu).toList();
  }

  return [];
}
