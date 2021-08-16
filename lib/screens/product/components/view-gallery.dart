import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:shop/define.dart';
import 'package:shop/models/entity/Product/Media.dart';
import 'package:shop/ui/back.dart';

class ViewGallery extends StatefulWidget {
  final int init;
  final List<Media> media;
  final PageController pageController;

  ViewGallery({
    Key? key,
    required this.init,
    required this.media,
  })  : pageController = PageController(initialPage: init, keepPage: true),
        super(key: key);

  @override
  _ViewGalleryState createState() => _ViewGalleryState();
}

class _ViewGalleryState extends State<ViewGallery> {
  int _current = 0;

  @override
  void initState() {
    _current = widget.init;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mediaHeight = MediaQuery.of(context).size.height;
    final mediaViewImg = mediaHeight - (mediaHeight * 0.3);
    return _Layout(
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(kDefaultPadding),
            height: mediaViewImg,
            child: PhotoViewGallery.builder(
                backgroundDecoration: BoxDecoration(
                  color: Colors.transparent,
                ),
                scrollPhysics: const BouncingScrollPhysics(),
                pageController: widget.pageController,
                onPageChanged: (index) => setState(() => _current = index),
                itemCount: widget.media.length,
                builder: (BuildContext context, int index) {
                  final Media row = widget.media[index];
                  final String uri = 'https://jnz3dtiuj77ca.dummycachetest.com/media/catalog/product/' + row.file;

                  return PhotoViewGalleryPageOptions(
                    imageProvider: CachedNetworkImageProvider(uri),
                    minScale: 0.03,
                    maxScale: 0.8,
                    initialScale: PhotoViewComputedScale.contained,
                    tightMode: true,
                    heroAttributes: PhotoViewHeroAttributes(
                      tag: "media-$uri",
                    ),
                  );
                }),
          ),
          Center(
            child: Container(
              height: 72,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildGallery(),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildGallery() {
    List<Widget> thumb = [];
    final controller = widget.pageController;
    for (int index = 0; index < widget.media.length; index++) {
      final Media row = widget.media[index];
      final String uri = 'https://jnz3dtiuj77ca.dummycachetest.com/media/catalog/product/${row.file}';

      thumb.add(GestureDetector(
        key: Key("thumb-$index"),
        onTap: () => controller.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease),
        child: Container(
          margin: EdgeInsets.only(
            right: kDefaultPadding / 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: _current == index ? kPrimaryColor : Colors.black12,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: CachedNetworkImageProvider(uri),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ));
    }

    return thumb;
  }
}

class _Layout extends StatelessWidget {
  final Widget child;

  const _Layout({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(context),
      body: Container(
        height: MediaQuery.of(context).size.height,
        child: child,
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: BackWidget(),
    );
  }
}
