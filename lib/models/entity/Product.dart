import 'package:shop/helper/mixins/base.dart';
import 'package:shop/models/entity/Product/Configurable/ConfigurableOption.dart';
import 'package:shop/models/entity/Product/Configurable/Variants.dart';
import 'package:shop/models/entity/Product/Media.dart';
import 'package:shop/models/entity/Product/Price.dart';

mixin BaseMixin {
  late List<Media> media = [];
  late String description = '';
}

class SimpleProduct with BaseMixin {
  final int id;
  final String sku, name, typeId, status, urlKey;
  final ProductPrice price;

  SimpleProduct({
    required this.id,
    required this.sku,
    required this.name,
    required this.typeId,
    required this.status,
    required this.urlKey,
    required this.price,
  });
}

mixin ConfigurableProduct {
  List<ConfigurableOption> configurableOptions = [];
  List<Variant> variants = [];
}

class ProductEntity extends SimpleProduct with Loading, ConfigurableProduct {
  ProductEntity({
    required id,
    required sku,
    required name,
    required status,
    required typeId,
    required urlKey,
    required price,
  }) : super(
      id: id,
      sku: sku,
      name: name,
      status: status,
      typeId: typeId,
      urlKey: urlKey,
      price: price,
  );
}
