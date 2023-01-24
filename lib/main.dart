import 'package:flutter/material.dart';
import 'package:mallmap/cubits/cart_cubit.dart';
import 'package:mallmap/map_view.dart';
import 'package:mallmap/scanner_page.dart';
import 'package:mallmap/shop_catalogue_page.dart';
import 'package:mallmap/view_cart_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final CartCubit cartCubit = CartCubit();
  MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mall Map',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Mall Mapper', cartCubit: cartCubit),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title, required this.cartCubit})
      : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  final CartCubit cartCubit;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Row(
          children: [
            // IconButton(onPressed: () {}, icon: const Icon(Icons.qr_code)),
            Text(widget.title),
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: ((context) {
                  return const ShopCataloguePage();
                })));
              },
              icon: const Icon(Icons.menu)),
          IconButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return ViewCartPage(widget.cartCubit);
                }));
              },
              icon: const Icon(Icons.shopping_cart))
        ],
      ),
      body: const MapView(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return ScannerPage(
              cartCubit: widget.cartCubit,
            );
          }));
        },
        tooltip: 'Increment',
        child: const Icon(Icons.qr_code),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
