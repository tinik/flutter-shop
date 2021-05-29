import 'package:redux/redux.dart';
import 'package:shop/actions/middlewares/application.dart';
import 'package:shop/actions/middlewares/category.dart';
import 'package:shop/actions/middlewares/products.dart';
import 'package:shop/actions/reducers.dart';
import 'package:shop/actions/state.dart';

Store createStore() {
  return new Store<AppState>(
    reduce,
    initialState: AppState(navigation: [], category: {}, products: {}, storeConfig: {}),
    middleware: [
      AppMiddleware(),
      CategoryMiddleware(),
      ProductsMiddleware(),
    ],
  );
}
