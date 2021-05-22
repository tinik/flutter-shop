import 'package:flutter/material.dart';
import 'package:shop/define.dart';

class CounterWidget extends StatefulWidget {
  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CounterWidget> {
  int itemCount = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: OutlinedButton(
              child: Text(
                "-",
                style: TextStyle(color: kTextColor),
              ),
              onPressed: () => setState(() {
                if (itemCount > 1) {
                  --itemCount;
                }
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: Text(itemCount.toString().padLeft(2, '0')),
          ),
          Container(
            alignment: Alignment.center,
            width: 40,
            height: 40,
            child: OutlinedButton(
              child: Text(
                "+",
                style: TextStyle(color: kTextColor),
              ),
              onPressed: () {
                setState(() => ++itemCount);
              },
            ),
          ),
        ],
      ),
    );
  }
}
