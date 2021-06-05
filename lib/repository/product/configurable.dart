import 'dart:convert';
import 'dart:developer' as developer;

import 'package:flutter/foundation.dart';
import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';
import 'package:shop/models/entity/Product.dart';
import 'package:shop/models/entity/Product/Configurable/ConfigurableOption.dart';
import 'package:shop/models/entity/Product/Configurable/Variants.dart';

ProductEntity _prepareProduct(ProductEntity entity, Map<String, dynamic> data) {
  if (data.containsKey('variants')) {
    final List<Variant> variants = [];
    data['variants'].forEach((row) {
      variants.add(Variant.fromJson(row));
    });

    entity.variants = variants;
  }

  if (data.containsKey('configurable_options')) {
    final List<ConfigurableOption>options = [];
    data['configurable_options'].forEach((row) {
      options.add(ConfigurableOption.fromJson(row));
    });

    entity.configurableOptions = options;
  }

  return entity;
}

final _queryProduct = gql(r'''
query getConfigurableProduct($key: String!) {
  products(filter: {url_key: {eq: $key}}) {
    items {
      id
      ...ConfigurableFragment
    }
  }
}

fragment ConfigurableFragment on ProductInterface {
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
        value_index
        code
      }
      product {
        id
        sku
        name
        url_key
        type_id
        stock_status
        media_gallery_entries {
          id
          file
          label
          position
          disabled
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

Future<ProductEntity> getConfigurable(ProductEntity entity) async {
  final client = getClient();

  final QueryResult result = await client.query(QueryOptions(
    fetchPolicy: FetchPolicy.cacheFirst,
    document: _queryProduct,
    variables: {
      "key": entity.urlKey,
    },
  ));

  if (!kReleaseMode) {
    developer.log('-' * 80);
    developer.log(json.encode(result.data));
    developer.log('-' * 80);
  }

  final dynamic data = result.data!['products']['items'][0];
  _prepareProduct(entity, data);

  return entity;
}
