import 'package:flutter/cupertino.dart';
import 'package:shop/define.dart';
import 'package:shop/screens/category/components/gallery-item.dart';

class CategoryGallery extends StatefulWidget {
  final List products;
  final Function onLoadingMore;

  CategoryGallery({
    Key? key,
    required this.products,
    required this.onLoadingMore
  }) : super(key: key);

  @override
  _LoadingGallery createState() => _LoadingGallery();
}

class _LoadingGallery extends State<CategoryGallery> {
  late ScrollController controller;

  @override
  void initState() {
    super.initState();
    controller = new ScrollController()..addListener(_scrollListener);
  }

  @override
  void dispose() {
    controller.removeListener(_scrollListener);
    super.dispose();
  }

  void _scrollListener() {
    if (controller.position.extentAfter < 500) {
      widget.onLoadingMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: kDefaultPadding / 2.5,
          ),
          child: GridView.builder(
            controller: controller,
            itemCount: widget.products.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: kDefaultPadding / 2,
              crossAxisSpacing: kDefaultPadding / 2,
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) => GalleryItem(
              item: widget.products[index],
            ),
          ),
        ),
      ),
    );
  }
}
