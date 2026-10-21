import 'package:flutter/material.dart';

enum CustomButtonStyle {
  primary,
  secondary,
  danger,
  outline,
}

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final CustomButtonStyle style;
  final Widget? icon;
  final bool isLoading;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.style = CustomButtonStyle.primary,
    this.icon,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    final Color background;
    final Color foreground;

    switch (style) {
      case CustomButtonStyle.primary:
        background = colors.primary;
        foreground = colors.onPrimary;
        break;
      case CustomButtonStyle.secondary:
        background = colors.secondaryContainer;
        foreground = colors.onSecondaryContainer;
        break;
      case CustomButtonStyle.danger:
        background = colors.error;
        foreground = colors.onError;
        break;
      case CustomButtonStyle.outline:
        background = Colors.transparent;
        foreground = colors.primary;
        break;
    }

    final Widget child = isLoading
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 2),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                icon!,
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );

    if (style == CustomButtonStyle.outline) {
      return SizedBox(
        width: double.infinity,
        child: OutlinedButton(
          onPressed: isLoading ? null : onPressed,
          child: child,
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      child: FilledButton(
        onPressed: isLoading ? null : onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: background,
          foregroundColor: foreground,
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: child,
      ),
    );
  }
}
