import 'package:ak_fashion_flutter/screens/productDetails.dart';
import 'package:ak_fashion_flutter/state/productState.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_card.dart';
import '../widgets/custom_text.dart';
import '../theme/text_styles.dart';

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
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          ProductDetailsScreen.routeName,
          arguments: id,
        );
      },
      child: CustomCard(
        borderRadius: 16,
        useShadow: true,
        padding: EdgeInsets.zero,
        margin: const EdgeInsets.all(8),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Product Image
              Positioned.fill(
                child: Image.network(
                  ProductState.baseUrl + imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Icon(
                    Icons.broken_image,
                    size: 50,
                    color: theme.colorScheme.onSurface.withOpacity(0.4),
                  ),
                  loadingBuilder: (context, child, progress) {
                    if (progress == null) return child;
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: theme.colorScheme.primary,
                      ),
                    );
                  },
                ),
              ),

              // Gradient Overlay
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),

              // Title + Favourite
              Positioned(
                bottom: 8,
                left: 12,
                right: 12,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomText(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyles.buttonLarge
                            .withColor(Colors.white),
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(30),
                      onTap: () {
                        Provider.of<ProductState>(context, listen: false)
                            .favouriteButton(id);
                      },
                      child: CircleAvatar(
                        radius: 16,
                        backgroundColor:
                        theme.colorScheme.surface.withOpacity(0.9),
                        child: Icon(
                          isFavourite ? Icons.favorite : Icons.favorite_border,
                          size: 18,
                          color: isFavourite ? Colors.red : theme.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
