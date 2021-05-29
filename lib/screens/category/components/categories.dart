import 'package:flutter/material.dart';
import 'package:shop/define.dart';

class Categories extends StatelessWidget {
  final children;
  final Function(int id) onSelect;

  const Categories({
    Key? key,
    required this.children,
    required this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (children.length > 0) {
      return createItems(children);
    }

    return Container();
  }

  Padding createItems(children) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
      child: SizedBox(
        height: 18,
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
      onTap: () => onSelect(category.id),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
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
            // Container(
            //   margin: EdgeInsets.only(top: kDefaultPadding / 5),
            //   height: 2,
            //   width: 30,
            //   // color: selected == index ? Colors.black : Colors.transparent,
            // ),
          ],
        ),
      ),
    );
  }
}
