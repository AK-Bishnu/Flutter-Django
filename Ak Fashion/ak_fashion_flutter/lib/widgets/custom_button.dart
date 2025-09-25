import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../theme/text_styles.dart';

enum ButtonType { primary, secondary, text }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final IconData? icon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    Color background;
    Color foreground;
    Color shadowColor;

    switch (type) {
      case ButtonType.primary:
        background = AppColors.primary;
        foreground = AppColors.buttonText(isDark);
        shadowColor = AppColors.shadow(isDark);
        break;
      case ButtonType.secondary:
        background = AppColors.card(isDark);
        foreground = AppColors.textPrimary(isDark);
        shadowColor = AppColors.shadow(isDark);
        break;
      case ButtonType.text:
        background = Colors.transparent;
        foreground = AppColors.primary;
        shadowColor = Colors.transparent;
        break;
    }

    final child = Text(
      text,
      style: TextStyles.buttonLarge.withColor(foreground),
    );

    if (type == ButtonType.text) {
      // TextButton
      return TextButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon, size: 20, color: foreground)
            : const SizedBox.shrink(),
        label: child,
      );
    }

    // Elevated button
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon != null
          ? Icon(icon, size: 20, color: foreground)
          : const SizedBox.shrink(),
      label: child,
      style: ElevatedButton.styleFrom(
        backgroundColor: background,
        foregroundColor: foreground,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        shadowColor: shadowColor,
        textStyle: TextStyles.buttonLarge,
      ),
    );
  }
}
