
import 'package:shop/models/entity/Product/Price.dart';

ProductPrice createProductPrice(dynamic row) {
  late double special = 0;
  final double regular = (1.00 * row['price']['regularPrice']['amount']['value']);

  try {
    if (row.containsKey('special_price')) {
      special = (1.00 * row['special_price']);
    }
  } catch (err) {
    // ignore
  }

  return ProductPrice(regular, special);
}