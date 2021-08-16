import 'package:shop/helper/product/media.dart';
import 'package:shop/helper/product/price.dart';
import 'package:shop/models/entity/Product.dart';

class Variant {
  List<dynamic> attributes = [];
  SimpleProduct product;

  Variant(this.attributes, this.product);

  static Variant fromJson(dynamic row) {
    List<dynamic> attributes = row['attributes'];

    final data = row['product'];
    final SimpleProduct product = SimpleProduct(
      id: data['id'],
      sku: data['sku'],
      name: data['name'],
      urlKey: data['url_key'],
      typeId: data['type_id'],
      status: data['stock_status'],
      price: createProductPrice(data),
    );
    product.media = createProductMedia(data);

    return Variant(attributes, product);
  }
}
