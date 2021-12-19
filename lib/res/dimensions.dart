import 'package:flutter/material.dart';

class SupportDeskMargins {
  static const double small = 8.0;
  static const double medium = 16.0;
  static const double large = 20.0;

  SupportDeskMargins._();
}

extension MarginExtensions on double {
  Widget toSpace({bool horizontally = true, bool vertically = true}) {
    assert(horizontally != false || vertically != false);
    return SizedBox(
      width: horizontally ? this : 0,
      height: vertically ? this : 0,
    );
  }
}
