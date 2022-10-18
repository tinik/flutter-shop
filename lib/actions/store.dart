import 'package:redux/redux.dart';
import 'package:shop/actions/middlewares/application.dart';
import 'package:shop/actions/middlewares/cart.dart';
import 'package:shop/actions/middlewares/category.dart';
import 'package:shop/actions/middlewares/products.dart';
import 'package:shop/actions/middlewares/search.dart';
import 'package:shop/actions/reducers.dart';
import 'package:shop/actions/state.dart';

const _defaultProfile = {
  "is_auth": false,
};

final state = AppState(
  cart: {},
  navigation: [],
  category: {},
  products: {},
  storeConfig: {},
  search: {},
  profile: _defaultProfile,
);

Store createStore() {
  return new Store<AppState>(
    reduce,
    initialState: state,
    middleware: [
      AppMiddleware(),
      CartMiddleware(),
      //
      CategoryMiddleware(),
      ProductsMiddleware(),
      //
      SearchMiddleware(),
    ],
  );
}
