import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Text label;
  final Icon? icon;
  final Color? backgroundColor;
  final VoidCallback onPressed;

  const ButtonWidget({
    Key? key,
    required this.label,
    this.icon,
    this.backgroundColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(backgroundColor: backgroundColor),
      onPressed: onPressed,
      icon: Visibility(visible: icon != null, child: icon ?? const Icon(null)),
      label: label,
    );
  }
}
