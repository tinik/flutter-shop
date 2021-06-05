import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/actions/store.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/home/screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Store store;

  MyApp({
    Key? key,
  })  : store = createStore(),
        super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    store.dispatch(AppLoading());

    return StoreProvider<AppState>(
      store: store as Store<AppState>,
      child: MaterialApp(
        theme: ThemeData(
          textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(primary: kTextColor),
          ),
        ),
        home: ScreenHome(),
      ),
    );
  }
}
