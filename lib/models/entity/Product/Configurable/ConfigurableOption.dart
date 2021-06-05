class ConfigurableOption {
  final int id;
  final String attributeId, attributeCode, label;
  final List<dynamic> values;

  ConfigurableOption(this.id, this.attributeId, this.attributeCode, this.label, this.values);

  static ConfigurableOption fromJson(dynamic row) => ConfigurableOption(
        row['id'],
        row['attribute_id'],
        row['attribute_code'],
        row['label'],
        row['values'],
      );
}
