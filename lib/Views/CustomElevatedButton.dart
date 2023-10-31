import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? icon; // Make it optional
  final Widget label;
  final Color backgroundColor;
  final Color foregroundColor;

  const CustomElevatedButton({
    required this.onPressed,
    this.icon, // Optional now
    required this.label,
    this.backgroundColor = Colors.white, // Default value
    this.foregroundColor = Colors.black, // Default value
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon ?? const SizedBox(), // If no icon is provided, show an empty space
      label: label,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return Colors.grey.withOpacity(0.2);
            }
            return null;
          },
        ),
      ),
    );
  }
}
