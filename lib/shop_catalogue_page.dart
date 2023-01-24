import 'package:flutter/material.dart';
import 'package:mallmap/comps/uifuncs.dart';
import 'package:mallmap/models.dart';

class ShopCataloguePage extends StatefulWidget {
  const ShopCataloguePage({Key? key}) : super(key: key);

  @override
  State<ShopCataloguePage> createState() => _ShopCataloguePageState();
}

class _ShopCataloguePageState extends State<ShopCataloguePage> {
  static const int viewState = 0;
  static const int searchState = 1;
  int appBarState = viewState;
  String searchQuery = '';
  TextEditingController controller = TextEditingController();
  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        searchQuery = controller.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _getAppBar(),
      body: _getProductList(searchQuery),
    );
  }

  AppBar _getAppBar() {
    switch (appBarState) {
      case viewState:
        return _getViewStateAppBar();
      case searchState:
        return _getSearchStateAppBar();
    }
    return _getViewStateAppBar();
  }

  AppBar _getViewStateAppBar() {
    return AppBar(
      title: const Text('Catalogue'),
      actions: [
        IconButton(
            onPressed: () {
              setState(() {
                appBarState = searchState;
              });
            },
            icon: const Icon(Icons.search))
      ],
    );
  }

  AppBar _getSearchStateAppBar() {
    return AppBar(
      title: getTextField(controller),
      actions: [
        IconButton(
            onPressed: () {
              controller.clear();
              setState(() {
                appBarState = viewState;
              });
            },
            icon: const Icon(Icons.cancel))
      ],
    );
  }

  Widget getTextField(TextEditingController controller) {
    return Container(
        height: 40,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            autofocus: true,
            controller: controller,
            style: const TextStyle(fontSize: 20),
          ),
        ));
  }

  Widget _getProductList(String q) {
    return Column(
      children: Product.getDummies()
          .where((element) =>
              element.title.toLowerCase().contains(q.toLowerCase()))
          .toList()
          .map((e) => makeProductCard(e, context, null))
          .toList(),
    );
  }
}
