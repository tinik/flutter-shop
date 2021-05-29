import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';
import 'package:shop/helper/product/media.dart';
import 'package:shop/helper/product/price.dart';
import 'package:shop/models/entity/Product.dart';

ProductEntity _prepareProduct(dynamic row) {
  final price = createProductPrice(row);
  final media = createProductMedia(row);

  return ProductEntity(
    id: row['id'],
    sku: row['sku'],
    name: row['name'],
    status: row['stock_status'],
    typeId: row['type_id'],
    urlKey: row['url_key'],
    price: price,
    media: media,
    description: row['description']['html'],
  );
}

final _queryProduct = gql(r'''
query getProduct($key: String!) {
  products(filter: {url_key: {eq: $key}}) {
    items {
      id
      ...ProductFragment
    }
  }
}

fragment ProductFragment on ProductInterface {
  id
  sku
  name
  url_key
  type_id
  special_price
  stock_status
  price {
    regularPrice {
      amount {
        currency
        value
      }
    }
  }
  media_gallery_entries {
    id
    label
    position
    disabled
    file
  }
  description {
    html
  }
}
''');

Future<ProductEntity> getProduct(String key) async {
  final client = getClient();

  final QueryResult result = await client.query(QueryOptions(
    errorPolicy: ErrorPolicy.ignore,
    fetchPolicy: FetchPolicy.cacheFirst,
    document: _queryProduct,
    variables: {
      "key": key,
    },
  ));

  final dynamic data = result.data!['products']['items'][0];
  return _prepareProduct(data);
}
