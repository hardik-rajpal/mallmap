import 'package:flutter/material.dart';

class UIFuncs {
  static double vthres = 0.9;
  static double getVofHSV(Color color) {
    int r, g, b;
    r = color.red;
    g = color.green;
    b = color.blue;
    double brightness =
        0.299 * (r / 255) + 0.587 * (g / 255) + 0.114 * (b / 255);
    return brightness;
  }

  static Color getTextColor(Color bgColor) {
    return (UIFuncs.getVofHSV(bgColor) > vthres) ? Colors.black : Colors.white;
  }

  static toast({required BuildContext context, required String text}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }
}
