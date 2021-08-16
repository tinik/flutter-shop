import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:shop/actions/state.dart';
import 'package:shop/define.dart';
import 'package:shop/functions/price.dart';
import 'package:shop/screens/product/components/counter.dart';

dynamic getValueByPath(Map<String, dynamic> data, {required String path}) {
  final List<String> pathList = path.split('.');
  final List<String> remainingPath = path.split('.');

  for (String element in pathList) {
    remainingPath.remove(element);
    if (data[element] is Map<String, dynamic>) {
      return getValueByPath(data[element], path: remainingPath.join('.'));
    } else {
      return data[element];
    }
  }

  return null;
}

class _CartViewModel {
  final details;

  _CartViewModel({required this.details});

  static _CartViewModel fromState(Store<AppState> store) => _CartViewModel(
        details: store.state.cart,
      );
}

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StoreConnector<AppState, _CartViewModel>(
        converter: _CartViewModel.fromState,
        builder: (context, vm) {
          if (vm.details != null) {
            try {
              return _viewCart(context, vm);
            } on Exception catch (e, s) {
              print(s);
            }
          }

          return Container(
            alignment: Alignment.center,
            child: Text("Cart is empty"),
          );
        });
  }

  Widget _viewCart(BuildContext context, vm) {
    final value = Map<String, dynamic>.from(vm.details['details']);
    final grand = getValueByPath(value, path: 'prices.grand_total.value');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Cart",
                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
              ),
              Text(
                "\$ ${format(grand)}",
                style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: const EdgeInsets.only(
              top: kDefaultPadding * 1.5,
            ),
            child: CartPage(
              details: value,
            ),
          ),
        ),
      ],
    );
  }
}

class CartPage extends StatefulWidget {
  final details;

  const CartPage({Key? key, required this.details}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _CartPageState();
  }
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    final items = getValueByPath(widget.details, path: 'items');

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        final row = items[index];
        final image = getValueByPath(row, path: 'product.thumbnail.url');
        final name = getValueByPath(row, path: 'product.name');

        return Dismissible(
          key: UniqueKey(),
          direction: DismissDirection.endToStart,
          onDismissed: (DismissDirection direction) {
            print('- Action - delete handle -');
          },
          secondaryBackground: Container(
            color: Colors.red,
            child: Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(kDefaultPadding),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Delete',
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                    Icon(
                      Icons.delete,
                      color: Colors.white,
                      size: 32,
                    ),
                  ],
                ),
              ),
            ),
          ),
          background: Container(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => null,
                    child: Container(
                      width: 98,
                      height: 98,
                      margin: const EdgeInsets.only(
                        left: kDefaultPadding,
                        right: kDefaultPadding,
                      ),
                      child: Hero(
                        tag: "media-$image",
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.network(image),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                          child: Text(
                            name,
                            style: TextStyle(color: kTextColor, fontSize: 18),
                            textAlign: TextAlign.start,
                            maxLines: 2,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              createCounterWidget(row, context),
                              createPriceContainer(row, context),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Center(
                child: Container(
                  padding: const EdgeInsets.only(bottom: kDefaultPadding / 2),
                  width: 320,
                  child: Divider(
                    color: Colors.black26,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget createCounterWidget(dynamic row, BuildContext context) {
    return CounterWidget(
      initCount: row['quantity'],
    );
  }

  Widget createPriceContainer(dynamic row, BuildContext context) {
    final price = getValueByPath(row, path: 'prices.row_total.value');

    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.only(right: kDefaultPadding),
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: "\$ ${format(price)}",
              style: TextStyle(
                fontSize: 18,
                color: kTextColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
