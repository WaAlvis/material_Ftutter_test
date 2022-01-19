import 'package:flutter/services.dart';

class NumericalRangeFormatter extends TextInputFormatter {

  final double min;
  final double max;

  NumericalRangeFormatter({required this.min, required this.max});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // final String value=changeSeparatorGroup(newValue.text);

    if (newValue.text == '') {
      return newValue;
    } else if (double.parse(changeSeparatorGroup(newValue.text)) < min) {
      return  TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return double.parse(changeSeparatorGroup(newValue.text)) > max ? oldValue : newValue;
    }
  }

  String changeSeparatorGroup(String value) {
    if (value.contains('.')) {
      return value.replaceAll('.', ',');
    } else {
      return value.replaceAll(',', '.');
    }
  }
}

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  static const String separator = '.'; // Change this to '.' for other locales

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    // En caso de que se eliminen los separadores de miles, se retorna el valor anterior.
    if (oldValue.text.contains(separator) &&
        !newValue.text.contains(separator) &&
        oldValue.text.replaceAll(separator, '').length ==
            newValue.text.length) {
      return oldValue;
    }

    // Short-circuit if the new value is empty
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    // Handle "deletion" of separator character
    final String oldValueText = oldValue.text.replaceAll(separator, '');
    String newValueText = newValue.text.replaceAll(separator, '');

    if (oldValue.text.endsWith(separator) &&
        oldValue.text.length == newValue.text.length + 1) {
      newValueText = newValueText.substring(0, newValueText.length - 1);
    }

    // Only process if the old value and new value are different
    if (oldValueText != newValueText) {
      final int selectionIndex =
          newValue.text.length - newValue.selection.extentOffset;
      final List<String> chars = newValueText.split('');

      String newString = '';
      for (int i = chars.length - 1; i >= 0; i--) {
        if ((chars.length - 1 - i) % 3 == 0 && i != chars.length - 1) {
          newString = separator + newString;
        }
        newString = chars[i] + newString;
      }

      return TextEditingValue(
        text: newString,
        selection: TextSelection.collapsed(
          offset: newString.length - selectionIndex,
        ),
      );
    }

    // If the new value and old value are the same, just return as-is
    return newValue;
  }
}
