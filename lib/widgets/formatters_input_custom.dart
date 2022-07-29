import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange, required this.min})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;
  final double min;


  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, // unused.
      TextEditingValue newValue,
      ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

    try {
      double.parse(newValue.text);
    }
   catch(e) {
     truncated = '0.';
     return newValue;
    }

    if (double.parse(newValue.text) < min && newValue.text.length > 2) {
      truncated = '$min';
    }
    if (decimalRange != null) {
      String value = newValue.text;

      if ((oldValue.text.length < newValue.text.length ||
          oldValue.text.length == newValue.text.length) &&
          newValue.text.length == 1) {
        value = '$value.';
        truncated = value;
        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      } else if (oldValue.text.length == 1 &&
          newValue.text[newValue.text.length - 1] != '.' &&
          newValue.text.length > 1) {
        final String lastNumber = newValue.text[newValue.text.length - 1];
        final double parsedValue = double.parse(newValue.text.split('').join('.'));
        value = parsedValue < min ? '$min' : '${oldValue.text}.$lastNumber';
        truncated = value;
        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      if (value.contains(".") &&
          value.substring(value.indexOf(".") + 1).length > decimalRange) {
        truncated = oldValue.text;
        newSelection = oldValue.selection;
      } else if (value == "." || value == ",") {
        truncated = "0.";

        newSelection = newValue.selection.copyWith(
          baseOffset: math.min(truncated.length, truncated.length + 1),
          extentOffset: math.min(truncated.length, truncated.length + 1),
        );
      }

      return TextEditingValue(
        text: truncated,
        selection: newSelection,
      );
    }
    return newValue;
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

