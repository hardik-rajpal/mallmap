import 'package:flutter/material.dart';
import 'package:mallmap/comps/dialog.dart';
import 'package:mallmap/models.dart';
import 'package:mallmap/view_cart_page.dart';

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

Card makeProductCard(
    Product product, BuildContext context, ViewCartPage? widget) {
  return Card(
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
      Image.network(
        product.imgurl,
        width: 100,
        height: 100,
      ),
      Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            product.title,
            style: const TextStyle(fontSize: 20),
          ),
          Text(product.description)
        ],
      ),
      Text(product.cost),
      (widget != null)
          ? Column(children: [
              IconButton(
                  onPressed: () {
                    confirmAction(
                        context: context,
                        onConfirm: () {
                          (widget).cartCubit.removeProduct(product.uuid);
                        });
                    //confirm delete...
                    //remove from widget.cartCubit
                  },
                  icon: const Icon(Icons.delete)),
              Text(product.qty.toString())
            ])
          : Container()
    ]),
  );
}
