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
    final aggregations = widget.aggregations;

    return Center(
      child: OutlinedButton(
        child: Text(
          'Filters',
          style: TextStyle(
            color: kTextColor,
          ),
        ),
        onPressed: () async {
          await showModalBottomSheet<void>(
            isDismissible: false,
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (BuildContext context) {
              return Container(
                height: MediaQuery.of(context).copyWith().size.height * 0.90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(20.0),
                    topRight: const Radius.circular(20.0),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: kDefaultPadding),
                      child: Text(
                        "Filter",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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
            },
          );
        },
      ),
    );
  }

  Widget _createActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
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
              Navigator.pop(context);
              setState(() => selected = widget.filters);
            },
          ),
        ],
      ),
    );
  }

  Widget _createOptions(Aggregation item) {
    return StatefulBuilder(builder: (context, setState) {
      return Container(
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
              padding: const EdgeInsets.symmetric(
                vertical: 0,
                horizontal: kDefaultPadding / 2,
              ),
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
