import 'package:shop/models/entity/Product/Media.dart';

List<Media> createProductMedia(dynamic row) {
  final List<Media> results = [];

  row['media_gallery_entries'].forEach((row) {
    final isDisable = row['disabled'] ?? false;
    if (isDisable) {
      return;
    }

    results.add(Media(
      row['id'],
      row['label'] ?? '',
      row['position'] ?? 99,
      isDisable,
      row['file'],
    ));
  });

  return results;
}
