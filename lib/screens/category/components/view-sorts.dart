import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/helper/enum.dart';

const List<dynamic> options = [
  {
    "label": "Best Match",
    "key": "relevance",
    "dir": SortBy.DESC,
  },
  {
    "label": "Price: Low to High",
    "key": "price",
    "dir": SortBy.ASC,
  },
  {
    "label": "Price: High to Low",
    "key": "price",
    "dir": SortBy.DESC,
  }
];

class Sorting extends StatelessWidget {
  final String sortKey;
  final SortBy sortDir;
  final Function onApply;

  Sorting({
    Key? key,
    required this.sortKey,
    required this.sortDir,
    required this.onApply,
  }) : super(key: key);

  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(kPrimaryColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.zero,
              side: BorderSide(
                color: kPrimaryColor,
              ),
            ),
          ),
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                right: 10,
              ),
              child: Icon(Icons.sort),
            ),
            Text(
              'Sorting',
              style: TextStyle(
                color: kTextColor,
              ),
            ),
          ],
        ),
        onPressed: () async {
          await showModalBottomSheet<void>(
            isDismissible: false,
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return buildContainer(context);
            },
          );
        },
      ),
    );
  }

  Container buildContainer(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * 0.90,
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: const Radius.circular(kDefaultPadding),
          topRight: const Radius.circular(kDefaultPadding),
        ),
      ),
      child: Column(
        children: [
          _createHeader(context),
          Flexible(
            child: ListView.builder(
              itemCount: options.length,
              itemBuilder: (context, index) => _createOptions(context, options[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Sorting",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
            constraints: BoxConstraints(),
            icon: Icon(Icons.close),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _createOptions(context, item) {
    String keyValue = item['key'] + "_" + item['dir'].toString();

    return RadioListTile(
      title: Text(
        item['label'],
        style: TextStyle(
          color: kTextColor,
          fontSize: 18.0,
          fontWeight: FontWeight.w500,
        ),
      ),
      value: keyValue,
      groupValue: sortKey + "_" + sortDir.toString(),
      onChanged: (value) {
        onApply(item['key'], item['dir']);
        Navigator.pop(context);
      },
    );
  }
}
