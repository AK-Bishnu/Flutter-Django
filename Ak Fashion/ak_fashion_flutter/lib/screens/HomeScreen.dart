import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/cartState.dart';
import '../state/productState.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_textField.dart';
import '../widgets/SingleProduct.dart';
import '../widgets/app_Drawer.dart';
import '../utils/spacing.dart';

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
    _loadCart();
    _loadOrders();
  }

  Future<void> _loadProducts() async {
    try {
      final success =
      await Provider.of<ProductState>(context, listen: false).getProducts();
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = !success;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError = true;
        });
      }
    }
  }

  Future<void> _loadCart() async {
    try {
      await Provider.of<CartState>(context, listen: false).fetchCart();
    } catch (e) {
      debugPrint('Error loading cart: $e');
    }
  }

  Future<void> _loadOrders() async {
    try {
      await Provider.of<CartState>(context, listen: false).fetchOrders();
    } catch (e) {
      debugPrint('Error loading orders: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final products = Provider.of<ProductState>(context).products;

    return Scaffold(
      drawer: !_isLoading && !_hasError ? const AppDrawer() : null,
      appBar: AppBar(
        title: CustomText(
          "AK Shop",
          style: theme.textTheme.bodyLarge
              ?.copyWith(color: theme.primaryColor),
        ),
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 1.5,
        actions: [
          IconButton(
            onPressed: _loadProducts,
            icon: Icon(Icons.refresh, color: theme.primaryColor),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _hasError
          ? _buildErrorState(theme)
          : products.isEmpty
          ? _buildEmptyState(theme)
          : RefreshIndicator(
        onRefresh: _loadProducts,
        child: Padding(
          padding: EdgeInsets.all(Spacing.md),
          child: GridView.builder(
            gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 4,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
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
        ),
      ),
    );
  }

  Widget _buildErrorState(ThemeData theme) {
    return Center(
      child: CustomCard(
        padding: EdgeInsets.all(Spacing.lg),
        useShadow: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 48),
            SizedBox(height: Spacing.sm),
            CustomText(
              "Failed to load products",
              style: theme.textTheme.bodyLarge,
            ),
            SizedBox(height: Spacing.md),
            ElevatedButton(
              onPressed: _loadProducts,
              style: ElevatedButton.styleFrom(
                backgroundColor: theme.primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: CustomText(
                "Retry",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.labelLarge?.color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Center(
      child: CustomCard(
        padding: EdgeInsets.all(Spacing.lg),
        useShadow: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag_outlined,
                color: theme.primaryColor, size: 48),
            SizedBox(height: Spacing.sm),
            CustomText(
              "No Products Available",
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.textTheme.labelLarge?.color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
