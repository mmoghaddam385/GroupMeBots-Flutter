
import 'package:flutter/material.dart';

void closeKeyboard(BuildContext context) {
  // Unfocus any TextFields and close the keyboard
  FocusScope.of(context).requestFocus(new FocusNode());
}
