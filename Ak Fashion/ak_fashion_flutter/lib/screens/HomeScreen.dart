import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:ak_fashion_flutter/state/productState.dart';
import 'package:ak_fashion_flutter/widgets/SingleProduct.dart';
import 'package:ak_fashion_flutter/widgets/app_Drawer.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});
  static const routeName = '/homescreen';

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  bool _isLoading = true;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _loadProducts();
    loadCart();
    _loadOrders();

  }
  Future<void> _loadOrders() async{
    try{
      await Provider.of<CartState>(context,listen: false).fetchOrders();
    }catch(e){
      print('error of loading orders');
      print(e);
    }
  }
  Future<void> loadCart() async{
    try{
      await Provider.of<CartState>(context,listen: false).fetchCart();
      //print('cart loaded successfully');
    }catch(e){
      print('error of loading cart');
      print(e);
    }
  }
  Future<void> _loadProducts() async {
    try {
      final result = await Provider.of<ProductState>(
        context,
        listen: false,
      ).getProducts();

      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = !result;
        });
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductState>(context).products;

    return Scaffold(
      drawer: !_isLoading && !_hasError ? AppDrawer() : null,
      appBar: AppBar(title: Text('Welcome to AK-Fashion')),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _hasError
          ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Failed to load products'),
            ElevatedButton(
              onPressed: _loadProducts,
              child: Text('Retry'),
            ),
          ],
        ),
      )
          : products.isEmpty
          ? Center(child: Text('No products available'))
          : GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return SingleProduct(
            id: products[index].id!.toInt(),
            imageUrl: products[index].image.toString(),
            title: products[index].title.toString(),
            isFavourite: products[index].favourite as bool,
          );
        },
      ),
    );
  }
}