import 'package:ak_fashion_flutter/screens/HomeScreen.dart';
import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:ak_fashion_flutter/state/productState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const routeName = '/ProductDetailsScreen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int;
    final product = Provider.of<ProductState>(context).getSingleProduct(id);
    return Scaffold(
      appBar: AppBar(
        title: Text('Product Details'),
      ),
      body: ListView(
        children: [
          Image.network(
            'http://10.29.169.204:8000${product.image}',
            fit: BoxFit.cover,
            height: 300,
          ),
          SizedBox(height: 20,),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Column(
                children: [
                  Text("Market Price : \$${product.marketPrice}"),
                  Text("Selling Price : \$${product.sellingPrice}"),
                ],
              ),
              SizedBox(width: 70,),
              ElevatedButton(onPressed: () async {
                final bool res = await Provider.of<ProductState>(context,listen: false).addToCart(id);
                if(res){
                  await Provider.of<CartState>(context,listen: false).fetchCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Product is added to cart successfully'),
                      backgroundColor: Colors.green,
                      duration: Duration(seconds: 2),
                    )
                  );
                  
                }else{
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Something went wrong'),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      )
                  );
                }
              }, child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(Icons.shopping_cart),
                  Text('Add to Cart')
                ],
              ))
            ],
          ),
          SizedBox(height: 20,),
          Text(product.description.toString())
        ],
      ),
    );
  }
}
