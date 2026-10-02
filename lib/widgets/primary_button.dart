import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expand;
  final bool compact;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expand = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: TokoColors.primary,
        foregroundColor: Colors.white,
        disabledBackgroundColor: TokoColors.primary.withValues(alpha: 0.45),
        elevation: 0,
        minimumSize: Size(48, compact ? 32 : 48),
        padding: EdgeInsets.symmetric(
          horizontal: compact ? 8 : 18,
          vertical: compact ? 5 : 12,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(compact ? 9 : 14),
        ),
        textStyle: TextStyle(
          fontSize: compact ? 11 : 14,
          fontWeight: FontWeight.w700,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: compact ? 14 : 18),
            SizedBox(width: compact ? 4 : 8),
          ],
          Text(label),
        ],
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
