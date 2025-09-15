import 'package:ak_fashion_flutter/state/productState.dart';
import 'package:ak_fashion_flutter/widgets/app_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/SingleProduct.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});
  static const routeName = "/FavouriteScreen";

  @override
  Widget build(BuildContext context) {
    final favourites = Provider.of<ProductState>(context).favourites;
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body:  GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: favourites.length,
        itemBuilder: (context, index) {
          return SingleProduct(
            id: favourites[index].id!.toInt(),
            imageUrl: favourites[index].image.toString(),
            title: favourites[index].title.toString(),
            isFavourite: favourites[index].favourite as bool,
          );
        },
      ),
    );
  }
}
