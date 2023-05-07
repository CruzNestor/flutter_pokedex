String convertUnitTenToUnitThousand(int unitTen){
  double unitThousand = unitTen * (1/10);
  return roundedDecimal(unitThousand, 2);
}

String roundedDecimal(double value, int decimal) {
  String rounded = value.toStringAsFixed(decimal).replaceFirst(RegExp(r'\.?0*$'), '');
  return rounded;
}