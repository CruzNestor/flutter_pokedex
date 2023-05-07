import 'package:flutter_test/flutter_test.dart';

import 'package:pokedex/src/core/utils/converter.dart';


void main() {

  group('Rounded', () { 
    test('Should return String with decimal rounded', () {
      double tValue = 0.3333333;
      final result = roundedDecimal(tValue, 2);
      expect(result, '0.33');
    });

    test('Should delete last zero in decimal', () {
      double tValue = 0.601;
      final result = roundedDecimal(tValue, 2);
      expect(result, '0.6');
    });
  });

  group('Converter', () { 
    test('Should return a String unit thousand', () {
      int tDecemetre = 7;
      final result = convertUnitTenToUnitThousand(tDecemetre);
      expect(result, '0.7');
    });
  });
}