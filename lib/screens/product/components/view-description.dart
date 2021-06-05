import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_html/flutter_html.dart';

class ExpandableText extends StatefulWidget {
  ExpandableText(this.text);

  final String text;
  bool isExpanded = false;

  @override
  _ExpandableTextState createState() => new _ExpandableTextState();
}

class _ExpandableTextState extends State<ExpandableText> with TickerProviderStateMixin<ExpandableText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        new AnimatedSize(
          vsync: this,
          duration: Duration(milliseconds: 350),
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: widget.isExpanded ? BoxConstraints() : BoxConstraints(maxHeight: 50),
            child: Html(
              data: widget.text,
              shrinkWrap: true,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.zero,
          padding: EdgeInsets.zero,
          alignment: Alignment.topRight,
          child: widget.isExpanded
              ? TextButton(
                  child: Text('less'),
                  onPressed: () => setState(() => widget.isExpanded = false),
                )
              : TextButton(
                  child: Text('more'),
                  onPressed: () => setState(() => widget.isExpanded = true),
                ),
        ),
      ],
    );
  }
}
