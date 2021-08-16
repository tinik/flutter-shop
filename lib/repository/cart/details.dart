import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';

final _queryCart = gql(r'''
query ($cartId: String!) {
  cart: cart (cart_id: $cartId) {
    id
    ...MiniCartFragment
  }
}

fragment MiniCartFragment on Cart {
  id
  ...ProductListFragment
  
  total_quantity
  prices {
    grand_total {
      value
      currency
    }
  }
}

fragment ProductListFragment on Cart {
  id
  items {
    id
    product {
      id
      name
      url_key
      thumbnail {
        url
      }
      stock_status
      ... on ConfigurableProduct {
        variants {
          attributes {
            uid
          }
          product {
            id
            thumbnail {
              url
            }
          }
        }
      }
    }
    prices {
      row_total {
        currency
        value
      }
    }
    quantity
    ... on ConfigurableCartItem {
      configurable_options {
        id
        value_id
        value_label
        option_label
      }
    }
  }
}
''');

Future<dynamic> cartDetails(cartId) async {
  final client = getClient();

  final QueryResult result = await client.query(QueryOptions(
    document: _queryCart,
    fetchPolicy: FetchPolicy.networkOnly,
    variables: {
      "cartId": cartId
    }
  ));

  // @todo: handle error
  return result.data!['cart'];
}