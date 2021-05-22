import 'package:flutter/material.dart';
import 'package:shop/define.dart';

class Categories extends StatelessWidget {
  final children;

  const Categories({Key? key, required this.children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (children.length > 0) {
      return createItems(children);
    }

    return Container();
  }

  Padding createItems(children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
      child: SizedBox(
        height: 25,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: children.length,
          itemBuilder: (context, index) => buildCategory(context, children[index]),
        ),
      ),
    );
  }

  Widget buildCategory(context, category) {
    return GestureDetector(
      onTap: () => null, // @todo: replace current route
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: kDefaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                // color: selected == index ? kTextColor : Colors.black38,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: kDefaultPadding / 4),
              height: 2,
              width: 30,
              // color: selected == index ? Colors.black : Colors.transparent,
            ),
          ],
        ),
      ),
    );
  }
}
