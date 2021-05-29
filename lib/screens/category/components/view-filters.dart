import 'package:flutter/material.dart';
import 'package:shop/define.dart';
import 'package:shop/repository/category/aggregation.dart';

class Aggregations extends StatefulWidget {
  final List aggregations;
  final Map filters;
  final Function onApply;

  Aggregations({
    Key? key,
    required this.aggregations,
    required this.filters,
    required this.onApply,
  }) : super(key: key);

  @override
  _AggregationState createState() => _AggregationState();
}

class _AggregationState extends State<Aggregations> {
  Map selected = {};

  @override
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
              child: Icon(Icons.filter_list_outlined),
            ),
            Text(
              'Filters',
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
              return _createWindow(context, widget.aggregations);
            },
          );
        },
      ),
    );
  }

  Widget _createWindow(BuildContext context, List<dynamic> aggregations) {
    return Container(
      height: MediaQuery.of(context).copyWith().size.height * 0.90,
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(kDefaultPadding),
          topRight: Radius.circular(kDefaultPadding),
        ),
      ),
      child: Column(
        children: [
          _createHeader(context),
          Flexible(
            child: ListView.builder(
              itemCount: aggregations.length,
              itemBuilder: (context, index) => _createOptions(aggregations[index]),
            ),
          ),
          _createActions(context),
        ],
      ),
    );
  }

  Widget _createHeader(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            "Filters",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          IconButton(
            padding: EdgeInsets.symmetric(vertical: kDefaultPadding),
            constraints: BoxConstraints(),
            icon: Icon(Icons.close),
            onPressed: () {
              setState(() => selected = widget.filters);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _createActions(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
        bottom: kDefaultPadding * 1.5,
        left: kDefaultPadding,
        right: kDefaultPadding,
      ),
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                side: BorderSide(
                  color: Colors.transparent,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                primary: kPrimaryColor,
                shadowColor: Colors.transparent,
                padding: const EdgeInsets.symmetric(
                  horizontal: kDefaultPadding / 1.5,
                  vertical: kDefaultPadding / 1.5,
                ),
              ),
              child: Text(
                'APPLY FILTERS'.toUpperCase(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                widget.onApply(selected);
                Navigator.pop(context);
              },
            ),
          ),
          TextButton(
            child: Text(
              'close'.toLowerCase(),
              style: TextStyle(
                fontSize: 16,
                color: kTextColor,
              ),
            ),
            onPressed: () {
              setState(() => selected = widget.filters);
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }

  Widget _createOptions(Aggregation item) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
        margin: EdgeInsets.only(bottom: kDefaultPadding / 2),
        decoration: BoxDecoration(
          color: kPrimaryBackground,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ExpansionTile(
          title: Text(
            item.label,
            style: TextStyle(
              color: kTextColor,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          children: [
            Container(
              alignment: Alignment.centerLeft,
              child: Column(
                children: item.options
                    .map((row) => CheckboxListTile(
                          controlAffinity: ListTileControlAffinity.leading,
                          title: Text(row.label),
                          value: selected.containsKey(item.code) && selected[item.code].contains(row.value),
                          onChanged: (status) {
                            final code = item.code;
                            final value = row.value;

                            List choices = [];
                            if (true == selected.containsKey(code)) {
                              choices = selected[code];
                            }

                            if (status == true || status == null) {
                              choices.add(value);
                            } else if (status == false) {
                              choices.remove(value);
                            }

                            setState(() => selected[code] = choices);
                          },
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      );
    });
  }
}
