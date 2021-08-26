import 'package:redux/redux.dart';
import 'package:shop/actions/middlewares/application.dart';
import 'package:shop/actions/middlewares/cart.dart';
import 'package:shop/actions/middlewares/category.dart';
import 'package:shop/actions/middlewares/products.dart';
import 'package:shop/actions/middlewares/search.dart';
import 'package:shop/actions/reducers.dart';
import 'package:shop/actions/state.dart';

final state = AppState(
  cart: {},
  navigation: [],
  category: {},
  products: {},
  storeConfig: {},
  search: {},
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
