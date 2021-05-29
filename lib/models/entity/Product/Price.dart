class ProductPrice {
  final double _regular;
  final double _special;

  ProductPrice(this._regular, this._special);

  double get regular => _regular;

  bool get isSpecial {
    if (_special > 0 && _special < _regular) {
      return true;
    }

    return false;
  }

  double get finish {
    if (true == isSpecial) {
      return _special;
    }

    return _regular;
  }
}