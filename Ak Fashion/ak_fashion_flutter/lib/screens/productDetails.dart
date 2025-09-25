import 'package:ak_fashion_flutter/screens/cartScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ak_fashion_flutter/state/cartState.dart';
import 'package:ak_fashion_flutter/state/productState.dart';
import 'package:ak_fashion_flutter/theme/colors.dart';
import 'package:ak_fashion_flutter/utils/spacing.dart';
import 'package:ak_fashion_flutter/widgets/custom_button.dart';
import 'package:ak_fashion_flutter/widgets/custom_text.dart';
import 'package:ak_fashion_flutter/widgets/custom_card.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});
  static const routeName = '/ProductDetailsScreen';

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  bool _isAdding = false;

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as int;
    final product = Provider.of<ProductState>(context).getSingleProduct(id);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: CustomText(
          product.title ?? 'Product Details',
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: Theme.of(context).primaryColor),
        ),
      ),
      body: ListView(
        padding: Spacing.pagePadding,
        children: [
          // Product Image
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(
                  ProductState.baseUrl + (product.image ?? ''),
                  fit: BoxFit.cover,
                  height: 320,
                  width: double.infinity,
                  errorBuilder: (context, error, stackTrace) =>
                  const Icon(Icons.broken_image,
                      size: 50, color: Colors.grey),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return const SizedBox(
                      height: 320,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    );
                  },
                ),
                // Gradient overlay for title
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 70,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.6),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    alignment: Alignment.bottomLeft,
                    child: CustomText(
                      product.title ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium
                          ?.copyWith(color: Colors.white),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: Spacing.xl),

          // Prices Card
          CustomCard(
            padding: Spacing.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Market Price: \$${product.marketPrice}",
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    decoration: TextDecoration.lineThrough,
                    decorationColor: isDark
                        ? Colors.white60
                        : Colors.black45,
                    color: isDark
                        ? AppColors.darkTextSecondary
                        : AppColors.lightTextSecondary,
                  ),
                ),
                SizedBox(height: Spacing.sm),
                CustomText(
                  "Selling Price: \$${product.sellingPrice}",
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge
                      ?.copyWith(color: AppColors.primary),
                ),
              ],
            ),
          ),

          SizedBox(height: Spacing.lg),

          // Description Card
          CustomCard(
            padding: Spacing.cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  "Description",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextPrimary,
                  ),
                ),
                SizedBox(height: Spacing.sm),
                CustomText(
                  product.description ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark
                        ? AppColors.darkTextPrimary
                        : AppColors.lightTextSecondary,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 120), // for spacing before bottom button
        ],
      ),

      // Fixed Add to Cart button
      bottomSheet: Container(
        color: Theme.of(context).scaffoldBackgroundColor,
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 55,
          child: CustomButton(
            text: _isAdding ? 'Adding...' : 'Add to Cart',
            onPressed: _isAdding
                ? null
                : () async {
              setState(() => _isAdding = true);
              final res = await Provider.of<ProductState>(context,
                  listen: false)
                  .addToCart(id);
              if (res) {
                await Provider.of<CartState>(context, listen: false)
                    .fetchCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Product added to cart successfully'),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
                Navigator.pushNamed(context, CartScreen.routeName);
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Something went wrong'),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 2),
                  ),
                );
              }
              setState(() => _isAdding = false);
            },
            icon: Icons.shopping_cart,
          ),
        ),
      ),
    );
  }
}
