import 'package:ak_fashion_flutter/screens/productDetails.dart';
import 'package:ak_fashion_flutter/state/productState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SingleProduct extends StatelessWidget {
  final int id;
  final String imageUrl;
  final String title;
  final bool isFavourite;

  const SingleProduct({
    super.key,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.isFavourite,
  });

  @override
  Widget build(BuildContext context) {
    return GridTile(
      footer: GridTileBar(
        backgroundColor: Colors.black54,
        title: Text(title),
        leading: IconButton(
          onPressed: () {
            Provider.of<ProductState>(context,listen: false).favouriteButton(id);
          },
          icon: isFavourite
              ? Icon(Icons.favorite_outlined, color: Colors.red)
              : Icon(Icons.favorite_border),
        ),
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.pushNamed(
            context,
            ProductDetailsScreen.routeName,
            arguments: id,
          );
        },
        child: Image.network(
          'http://10.29.169.204:8000$imageUrl',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
