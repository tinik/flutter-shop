import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/repository/navigation.dart';
import 'package:shop/screens/category/screen.dart';

class _NavigationViewModel {
  final navigation;

  _NavigationViewModel({required this.navigation});

  static _NavigationViewModel fromState(Store<AppState> store) => _NavigationViewModel(
        navigation: store.state.navigation,
      );
}

class Categories extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _NavigationViewModel>(
      converter: _NavigationViewModel.fromState,
      builder: (context, vm) {
        return Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.only(
                top: kDefaultPadding,
                right: kDefaultPadding,
                left: kDefaultPadding,
              ),
              child: Text(
                "Categories",
                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
              child: SizedBox(
                height: 25,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: vm.navigation.length,
                  itemBuilder: (context, index) => buildCategory(context, vm.navigation[index]),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget buildCategory(context, Menu category) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ScreenCategory(id: category.id),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.name,
              style: TextStyle(fontWeight: FontWeight.bold, color: kTextColor),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPadding / 4),
              height: 2,
              width: 30,
            ),
          ],
        ),
      ),
    );
  }
}
