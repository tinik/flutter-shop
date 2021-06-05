class ProductPrice {
  final double _regular;
  final double _special;

  ProductPrice(this._regular, this._special);

  double get regular => this._regular;

  bool get isSpecial {
    if (this._special > 0 && this._special < this._regular) {
      return true;
    }

    return false;
  }

  double get finish {
    if (true == this.isSpecial) {
      return this._special;
    }

    return this._regular;
  }
}