import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomTextField extends StatelessWidget {
  final String? label; // label shown above / inside
  final String? hintText;
  final IconData? icon;
  final bool obscureText;
  final TextEditingController? controller;
  final String? initialValue;
  final TextInputType keyboardType;
  final String? Function(String?)? validator; // <-- validator support
  final void Function(String?)? onSaved;     // <-- onSaved support for Form
  final void Function(String)? onChanged;
  final bool enabled;

  const CustomTextField({
    super.key,
    this.label,
    this.hintText,
    this.icon,
    this.obscureText = false,
    this.controller,
    this.initialValue,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.enabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return TextFormField(
      controller: controller,
      initialValue: controller == null ? initialValue : null,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: theme.textTheme.bodyMedium?.copyWith(
        color: AppColors.textPrimary(isDark),
      ),
      validator: validator,
      onSaved: onSaved,
      onChanged: onChanged,
      enabled: enabled,
      decoration: InputDecoration(
        labelText: label,
        hintText: hintText,
        labelStyle: theme.textTheme.bodyMedium?.copyWith(
          color: AppColors.textSecondary(isDark),
        ),
        hintStyle: theme.textTheme.bodySmall?.copyWith(
          color: AppColors.textSecondary(isDark),
        ),
        prefixIcon: icon != null
            ? Icon(icon, color: AppColors.textSecondary(isDark))
            : null,
        filled: true,
        fillColor: AppColors.card(isDark),
        contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border(isDark), width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.border(isDark), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),
    );
  }
}
