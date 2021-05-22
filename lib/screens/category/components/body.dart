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

class _CategoryViewModel {
  final category;
  final Function fetchCategory;
  final Function applyCategory;
  final Function itemsCategory;

  _CategoryViewModel({
    required this.category,
    required this.fetchCategory,
    required this.applyCategory,
    required this.itemsCategory,
  });

  static _CategoryViewModel fromState(Store<AppState> store) => _CategoryViewModel(
        category: store.state.category,
        fetchCategory: (id) => store.dispatch(CategoryFetch(id)),
        applyCategory: (vf) => store.dispatch(CategoryApply(vf)),
        itemsCategory: (page, limit) => store.dispatch(CategoryItems(page, limit)),
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
      converter: _CategoryViewModel.fromState,
      onDispose: (store) => store.dispatch(CategoryClean()),
      builder: (context, vm) {
        final entity = vm.category;
        if (null == entity || entity.data.id != this.id) {
          vm.fetchCategory(this.id);

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

        final category = entity.data;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
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
              children: category.children
            ),
            createFilters(entity, vm),
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
        margin: const EdgeInsets.symmetric(
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        createLoading(entity),
        Aggregations(
          aggregations: aggregations,
          filters: filters,
          onApply: (values) => vm.applyCategory(values),
        ),
      ],
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
      onLoadingMore: () => vm.itemsCategory(page + 1, 12),
    );
  }
}
