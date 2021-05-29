import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop/models/entity/Product/Media.dart';

class ViewImages extends StatefulWidget {
  final List<Media> media;

  const ViewImages({
    Key? key,
    required this.media,
  }) : super(key: key);

  @override
  _ImageState createState() => _ImageState();
}

class _ImageState extends State<ViewImages> {
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    late List<Widget> images = [];
    widget.media.asMap().forEach((int index, Media row) {
      final String uri = 'https://jnz3dtiuj77ca.dummycachetest.com/media/catalog/product/' + row.file;
      images.add(Container(
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image(
              image: CachedNetworkImageProvider(uri),
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ));
    });

    return Column(
      children: [
        CarouselSlider(
          items: images,
          options: CarouselOptions(
            autoPlay: false,
            pageSnapping: true,
            enlargeCenterPage: true,
            aspectRatio: 1,
            onPageChanged: (index, reason) {
              setState(() {
                _current = index;
              });
            },
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: widget.media.map((url) {
            int index = widget.media.indexOf(url);
            return Container(
              width: _current == index ? 24.0 : 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 2.0,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
                color: _current == index ? Color.fromRGBO(0, 0, 0, 0.9) : Color.fromRGBO(0, 0, 0, 0.4),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
