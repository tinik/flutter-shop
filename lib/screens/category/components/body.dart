import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/models/entity/Category.dart';
import 'package:shop/screens/category/components/categories.dart';
import 'package:shop/screens/category/components/view-filters.dart';
import 'package:shop/screens/category/components/view-items.dart';
import 'package:shop/screens/category/components/view-sorts.dart';
import 'package:shop/screens/category/screen.dart';

class _CategoryViewModel {
  final category;
  final Function fetchCategory;
  final Function applyCategory;
  final Function itemsCategory;
  final Function sortCategory;

  _CategoryViewModel({
    required this.category,
    required this.fetchCategory,
    required this.applyCategory,
    required this.itemsCategory,
    required this.sortCategory,
  });

  static _CategoryViewModel fromState(Store<AppState> store) => _CategoryViewModel(
        category: store.state.category,
        fetchCategory: (id) => store.dispatch(CategoryFetch(id)),
        applyCategory: (id, vf) => store.dispatch(CategoryApply(id, vf)),
        itemsCategory: (id, page, limit) => store.dispatch(CategoryItems(id, page, limit)),
        sortCategory: (id, key, dir) => store.dispatch(CategorySorting(id, key, dir)),
      );
}

class Body extends StatelessWidget {
  final int id;

  Body({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CategoryViewModel>(
      // Events
      onInit: (store) => store.dispatch(CategoryFetch(id)),
      // Widget
      converter: _CategoryViewModel.fromState,
      builder: (context, _CategoryViewModel vm) {
        final Map collection = vm.category;
        if (!collection.containsKey(id)) {
          return Center(
            child: Container(
              child: Text(
                'Loading...',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }

        final entity = collection[id];
        final category = entity.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: kDefaultPadding,
                  ),
                  child: Text(
                    category.name,
                    style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            Categories(
              children: category.children,
              onSelect: (int id) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ScreenCategory(id: id),
                  ),
                );
              },
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                createSorting(entity, vm),
                createFilters(entity, vm),
              ],
            ),
            createGallery(entity, vm),
          ],
        );
      },
    );
  }

  Widget createLoading(CategoryEntity entity) {
    final bool isBusy = entity.isBusy;
    if (true == isBusy) {
      return Container(
        width: 10,
        height: 10,
        margin: EdgeInsets.symmetric(
          horizontal: 7,
        ),
        child: CircularProgressIndicator(
          color: kPrimaryColor,
        ),
      );
    }

    return Container();
  }

  Widget createFilters(CategoryEntity entity, vm) {
    final aggregations = entity.aggregations;
    if (aggregations.length == 0) {
      return Container();
    }

    final filters = entity.filters;
    return Expanded(
      child: Aggregations(
        aggregations: aggregations,
        filters: filters,
        onApply: (values) => vm.applyCategory(this.id, values),
      ),
    );
  }

  Widget createGallery(CategoryEntity entity, vm) {
    final items = entity.items;
    if (entity.isBusy == false && items.length == 0) {
      return Container(
        alignment: Alignment.center,
        child: Text("Not found items"),
      );
    }

    final int page = (items.length / 12).ceil();
    return CategoryGallery(
      products: items,
      onLoadingMore: () => vm.itemsCategory(this.id, page + 1, 12),
    );
  }

  createSorting(entity, vm) {
    return Expanded(
      child: Sorting(
        sortKey: entity.sortKey,
        sortDir: entity.sortDir,
        onApply: (key, dir) => vm.sortCategory(this.id, key, dir),
      ),
    );
  }
}
