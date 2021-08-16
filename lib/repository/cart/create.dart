import 'package:graphql/client.dart';
import 'package:shop/helper/client.dart';

final _queryCart = gql(r'''
  mutation createCart {
    cartId: createEmptyCart
  }
''');

Future<String?> cartCreate() async {
  final client = getClient();

  final QueryResult result = await client.mutate(MutationOptions(
    document: _queryCart,
  ));

  // @todo: handle error
  return result.data!['cartId'];
}
