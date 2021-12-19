import 'package:flutter/material.dart';
import 'package:support_desk/res/styles.dart';

class UiUtils {

  static InputDecoration etInputDecoration({
    @required hint,
    String? prefixText,
  }) {
    return InputDecoration(
      hintText: hint,
      alignLabelWithHint: true,
      border: InputBorder.none,
      enabledBorder: Style.etBorder,
      disabledBorder: Style.etBorder,
      focusedBorder: Style.etBorder,
    );
  }
}
