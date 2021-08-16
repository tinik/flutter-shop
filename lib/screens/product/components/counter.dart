import 'package:flutter/material.dart';
import 'package:shop/define.dart';

typedef onHandleChanged = void Function(int count);

class CounterWidget extends StatefulWidget {
  int itemCount = 1;
  onHandleChanged? onChanged;

  CounterWidget({
    Key? key,
    int initCount = 1,
    this.onChanged,
  })  : itemCount = initCount,
        super(key: key);

  @override
  _CartCounterState createState() => _CartCounterState();
}

class _CartCounterState extends State<CounterWidget> {
  void triggerChange(int value) => setState(() {
        final int count = value + widget.itemCount;
        if (count > 0) {
          widget.itemCount = count;
          widget.onChanged?.call(count);
        }
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
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
              onPressed: () => triggerChange(-1),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: kDefaultPadding / 2,
            ),
            child: Text(
              widget.itemCount.toString().padLeft(2, '0'),
            ),
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
              onPressed: () => triggerChange(1),
            ),
          ),
        ],
      ),
    );
  }
}
