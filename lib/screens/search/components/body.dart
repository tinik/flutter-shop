import 'package:flutter/material.dart';
import 'package:flutter_html/shims/dart_ui_real.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/actions.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/category/components/view-items.dart';

class _SearchViewModel {
  final search;
  final Function fetchSearch;

  _SearchViewModel({
    required this.search,
    required this.fetchSearch,
  });

  static _SearchViewModel fromState(Store<AppState> store) => _SearchViewModel(
        search: store.state.search,
        fetchSearch: (value) => store.dispatch(SearchFetch(value)),
      );
}

class SearchBody extends StatelessWidget {
  final String input;

  const SearchBody({
    Key? key,
    required this.input,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _SearchViewModel>(
      key: Key("search-store-${this.input}"),
      // Events
      onInitialBuild: (_SearchViewModel vm) {
        vm.fetchSearch(input);
      },
      converter: _SearchViewModel.fromState,
      builder: (context, _SearchViewModel vm) {
        final Map collection = vm.search;

        if (!collection.containsKey(input)) {
          return Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(kDefaultPadding * 2),
            child: Text(
              'Loading...',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        }

        final dynamic details = collection[input];
        final int count = details['count'];

        return Expanded(
            child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(kDefaultPadding),
              child: Text('Showing results for $input: $count items'),
            ),
            createGallery(details)
          ],
        ));
      },
    );
  }

  Widget createGallery(vm) {
    final count = vm['count'];
    if (count == 0) {
      return Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(kDefaultPadding),
        child: Text('Noting found'),
      );
    }

    final items = vm['items'];
    return CategoryGallery(
      products: items,
      onLoadingMore: () => null,
    );
  }
}
