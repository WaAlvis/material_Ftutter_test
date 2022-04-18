import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math' as math;

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
      return TextEditingValue().copyWith(text: min.toStringAsFixed(2));
    } else {
      return double.parse(changeSeparatorGroup(newValue.text)) > max
          ? oldValue
          : newValue;
    }
  }

  String changeSeparatorGroup(String value) {
    if (value.contains('.')) {
      return value;
    } else {
      return value;
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

class DecimalTextInputFormatter extends TextInputFormatter {
  DecimalTextInputFormatter({required this.decimalRange})
      : assert(decimalRange == null || decimalRange > 0);

  final int decimalRange;

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue, // unused.
    TextEditingValue newValue,
  ) {
    TextSelection newSelection = newValue.selection;
    String truncated = newValue.text;

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

class TextNumberLimitFormatter extends TextInputFormatter {
  int _declen;
  int _intlen;

  TextNumberLimitFormatter(this._intlen, this._declen);

  RegExp exp = new RegExp("[0-9.]");
  static const String POINTER = ".";
  static const String ZERO = "0";

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    /// La entrada se elimina por completo
    if (newValue.text.isEmpty) {
      return TextEditingValue();
    }

    // Solo permite ingresar números y puntos decimales
    if (!exp.hasMatch(newValue.text)) {
      return oldValue;
    }

    /// Incluir un punto decimal
    if (newValue.text.contains(POINTER)) {
      // La precisión es 0, es decir, sin decimales
      if (_declen == 0) return oldValue;

      /// Contiene varios decimales
      if (newValue.text.indexOf(POINTER) !=
          newValue.text.lastIndexOf(POINTER)) {
        return oldValue;
      }
      String input = newValue.text;
      int index = input.indexOf(POINTER);

      /// Los dígitos antes del punto decimal
      int lengthBeforePointer = input.substring(0, index).length;

      /// La parte entera es mayor que la longitud acordada
      if (lengthBeforePointer > _intlen) {
        return oldValue;
      }

      /// Dígitos después del punto decimal
      int lengthAfterPointer = input.substring(index, input.length).length - 1;

      /// Los lugares decimales son mayores que la precisión
      if (lengthAfterPointer > _declen) {
        return oldValue;
      }
    } else if (
        // Empiece con un punto
        newValue.text.startsWith(POINTER) ||
            // Si el primer dígito es 0 y la longitud es mayor que 1, excluya todas las entradas ilegales 00, 01-09
            (newValue.text.startsWith(ZERO) && newValue.text.length > 1) ||
            // Si la longitud del número entero excede la longitud acordada
            newValue.text.length > _intlen) {
      return oldValue;
    }
    return newValue;
  }
}
