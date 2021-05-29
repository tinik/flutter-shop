import 'package:shop/models/entity/Product/Media.dart';
import 'package:shop/models/entity/Product/Price.dart';

class ProductEntity {
  final int id;
  final String sku, name, typeId, status, urlKey;
  final ProductPrice price;
  final List<Media> media;
  final String description;

  ProductEntity({
    required this.id,
    required this.sku,
    required this.status,
    required this.name,
    required this.typeId,
    required this.urlKey,
    required this.price,
    required this.media,
    required this.description,
  });
}
