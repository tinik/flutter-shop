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
query getConfigurableProduct($urlKey: String!) {
  products(filter: {url_key: {eq: $urlKey}}) {
    items {
      id
      ...ProductDetailsFragment
    }
  }
}

fragment ProductDetailsFragment on ProductInterface {
  id
  sku
  ... on ConfigurableProduct {
    configurable_options {
      id
      attribute_id
      attribute_code
      label
      values {
        default_label
        label
        store_label
        use_default_value
        value_index
        swatch_data {
          ... on ImageSwatchData {
            thumbnail
          }
          value
        }
      }
    }
    variants {
      attributes {
        code
        value_index
      }
      product {
        id
        sku
        stock_status
        media_gallery_entries {
          id
          disabled
          file
          label
          position
        }
        special_price
        price {
          regularPrice {
            amount {
              currency
              value
            }
          }
        }
      }
    }
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
