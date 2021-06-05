import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shop/define.dart';
import 'package:shop/models/entity/Product.dart';
import 'package:shop/models/entity/Product/Configurable/ConfigurableOption.dart';

class VariantWidget extends StatefulWidget {
  final ProductEntity product;

  VariantWidget({Key? key, required this.product}) : super(key: key);

  @override
  _VariantState createState() => _VariantState();
}

class _VariantState extends State<VariantWidget> {
  final ValueNotifier<Map<String, dynamic>> _values = ValueNotifier({});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Map<String, dynamic>>(
      valueListenable: _values,
      builder: (BuildContext context, Map<String, dynamic> value, Widget? child) {
        List<Widget> options = _createOptions();
        if (options.length > 0) {
          return Column(
            children: options,
          );
        }

        return Container();
      },
    );
  }

  List<Widget> _createValues(List<dynamic> values, ConfigurableOption row) {
    final String kRow = row.id.toString();

    final String typename = values[0]['swatch_data']['__typename'];
    if (typename.toLowerCase() == 'colorswatchdata') {
      return values.map((e) {
        final String index = e['value_index'].toString();
        final String value = e['swatch_data']['value'].toString();
        final bool isSelect = _values.value.containsKey(kRow) && _values.value[kRow] == index;

        return ColorCase(
          color: HexColor.fromHex(value),
          isChoice: isSelect,
          onChange: () => _values.value = {..._values.value, kRow: index},
        );
      }).toList();
    }

    return values.map((e) {
      final String index = e['value_index'].toString();
      final String value = e['swatch_data']['value'].toString();
      final bool isSelect = _values.value.containsKey(kRow) && _values.value[kRow] == index;

      return Container(
        padding: EdgeInsets.only(right: kDefaultPadding),
        child: TextCase(
          label: value,
          isChoice: isSelect,
          onChange: () => _values.value = {..._values.value, kRow: index},
        ),
      );
    }).toList();
  }

  List<Widget> _createOptions() {
    final options = widget.product.configurableOptions;
    if (options.length == 0) {
      return [];
    }

    final List<Widget> results = [];
    options.forEach((row) {
      final values = _createValues(row.values, row);
      if (values.length > 0) {
        final block = Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Text(
                row.label,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(children: values),
          ],
        );

        results.add(Container(
          child: block,
          padding: EdgeInsets.only(bottom: kDefaultPadding / 2),
        ));
      }
    });

    return results;
  }
}

class TextCase extends StatelessWidget {
  final String label;
  final bool isChoice;
  final Function onChange;

  const TextCase({
    Key? key,
    required this.label,
    required this.isChoice,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: OutlinedButton(
        child: Text(this.label),
        onPressed: () => this.onChange(),
        style: OutlinedButton.styleFrom(
          primary: isChoice ? kTextLightColor : kTextColor,
          backgroundColor: isChoice ? kPrimaryColor : Colors.transparent,
        ),
      ),
    );
  }
}

class ColorCase extends StatelessWidget {
  final Color color;
  final bool isChoice;
  final Function onChange;

  ColorCase({
    Key? key,
    required this.color,
    required this.isChoice,
    required this.onChange,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => this.onChange(),
      child: Container(
        height: 32,
        width: 32,
        margin: EdgeInsets.only(
          top: kDefaultPadding / 4,
          right: kDefaultPadding / 2,
        ),
        padding: EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 3,
            color: isChoice ? kPrimaryColor : Colors.transparent,
          ),
        ),
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: this.color,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}
