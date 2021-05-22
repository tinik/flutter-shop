import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';

/*
 *
 * @todo: add special price
 */
class Product {
  final int id;
  final String sku, name, thumbnail;
  final Price price;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.price,
    required this.thumbnail,
  });
}

class Price {
  final double _regular;
  final double _special;

  Price(this._regular, this._special);

  double get regular => _regular;

  bool get isSpecial {
    if (_special > 0 && _special < _regular) {
      return true;
    }

    return false;
  }

  double get finish {
    if (true == isSpecial) {
      return _special;
    }

    return _regular;
  }
}

Product _setPrepareProduct(dynamic row) {
  final regular = (1.00 * row['price']['regularPrice']['amount']['value']);
  double special = 0;

  try {
    if (row.containsKey('special_price')) {
      special = (1.00 * row['special_price']);
    }
  } catch (err) {}

  final price = Price(regular, special);
  return Product(
    id: row['id'],
    sku: row['sku'],
    name: row['name'],
    thumbnail: row['thumbnail']['url'],
    price: price,
  );
}

final _queryProducts = gql(r'''
  query getProducts($size: Int!, $page: Int!, $filters: ProductAttributeFilterInput!, $sort: ProductAttributeSortInput) {
    products(pageSize: $size, currentPage: $page, filter: $filters, sort: $sort) {
      total_count
      page: page_info {
        size: page_size
        page: current_page
        total_pages
      }
      items {
        id
        sku
        name
        special_price
        price {
          regularPrice {
            amount {
              currency
              value
            }
          }
        }
        thumbnail {
          url
        }
      }
    }
  } 
''');

Future<Map<String, dynamic>> getProducts(Map<String, dynamic> filters, {int page = 1, int size = 12}) async {
  final client = getClient();

  final sort = {"name": "ASC"};
  final QueryResult result = await client.query(QueryOptions(
    fetchPolicy: FetchPolicy.cacheFirst,
    document: _queryProducts,
    variables: {
      "filters": filters,
      "sort": sort,
      "size": size,
      "page": page,
    },
  ));

  if (result.hasException) {
    print(result.exception);
  }

  if (!result.isLoading && null != result.data) {
    final dynamic data = result.data!['products'];
    return {
      "items": data['items'].map(_setPrepareProduct).toList(),
      "count": data!['total_count'] ?? 0,
      "page": data!['page'] ?? {
        "size": 12,
        "page": 1,
        "total_pages": 0,
      }
    };
  }

  return {
    "items": [],
    "count": 0,
  };
}
