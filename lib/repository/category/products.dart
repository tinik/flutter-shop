import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';
import 'package:shop/helper/product/price.dart';
import 'package:shop/models/entity/Product/Price.dart';


class Product {
  final int id;
  final String sku, name, thumbnail, urlKey, typeId, status;
  final ProductPrice price;

  Product({
    required this.id,
    required this.sku,
    required this.name,
    required this.typeId,
    required this.status,
    required this.urlKey,
    required this.price,
    required this.thumbnail,
  });
}

Product _setPrepareProduct(dynamic row) {
  final price = createProductPrice(row);

  return Product(
    id: row['id'],
    sku: row['sku'],
    name: row['name'],
    typeId: row['type_id'],
    urlKey: row['url_key'],
    status: row['stock_status'],
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
        url_key
        type_id
        stock_status
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

Future<Map<String, dynamic>> getProducts(
  Map<String, dynamic> filters,
  int page,
  int size,
  String sortKey,
  String sortDir,
) async {
  final client = getClient();

  final QueryResult result = await client.query(QueryOptions(
    fetchPolicy: FetchPolicy.cacheFirst,
    document: _queryProducts,
    variables: {
      "filters": filters,
      "size": size,
      "page": page,
      "sort": {sortKey: sortDir},
    },
  ));

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
    "page": {
      "size": 12,
      "page": 1,
      "total_pages": 0,
    },
  };
}
