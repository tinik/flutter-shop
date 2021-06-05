import 'dart:collection';

import 'package:shop/helper/product/price.dart';
import 'package:shop/models/entity/Product.dart';

class Variant {
  List<dynamic> attributes = [];
  SimpleProduct product;

  Variant(this.attributes, this.product);

  static Variant fromJson(dynamic row) {
    List<dynamic> attributes = row['attributes'];

    final SimpleProduct product = SimpleProduct(
      id: row['product']['id'],
      sku: row['product']['sku'],
      name: row['product']['name'],
      urlKey: row['product']['url_key'],
      typeId: row['product']['type_id'],
      status: row['product']['stock_status'],
      price: createProductPrice(row['product']),
    );

    return Variant(attributes, product);
  }
}
