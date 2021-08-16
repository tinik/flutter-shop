import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';

final _queryCart = gql(r'''
mutation addConfigurableProductToCart ($cartId: String!, $quantity: Float!, $sku: String!, $parentSku: String!) {
  configurable: addConfigurableProductsToCart(input: {
    cart_id: $cartId, 
    cart_items: [{data: {quantity: $quantity, sku: $sku}, parent_sku: $parentSku}]
  }) {
    cart {
      id
      ...CartTriggerFragment
    }
  }
}

fragment CartTriggerFragment on Cart {
  id
  total_quantity
  prices {
    grand_total {
      value
      currency
    }
  }
}
''');

Future<dynamic> addConfigurableToCart(cartId, parentSku, sku, quantity) async {
  final client = getClient();

  final QueryResult result = await client.mutate(MutationOptions(
    document: _queryCart,
    variables: {
      "cartId": cartId,
      "sku": sku,
      "parentSku": parentSku,
      "quantity": quantity,
    }
  ));

  // @todo: handle error
  return result.data!['configurable'];
}
