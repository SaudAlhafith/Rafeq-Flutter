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
    final Brightness brightness = Theme.of(context).brightness;
    final Color overlayColor = brightness == Brightness.light
        ? Colors.grey.withOpacity(0.2)
        : Colors.white.withOpacity(0.2);

    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: icon ??
          const SizedBox(), // If no icon is provided, show an empty space
      label: label,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
      ).copyWith(
        overlayColor: MaterialStateProperty.resolveWith<Color?>(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.pressed)) {
              return overlayColor;
            }
            return null;
          },
        ),
      ),
    );
  }
}
