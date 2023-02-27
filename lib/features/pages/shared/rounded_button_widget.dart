import 'package:flutter/material.dart';

class RoundedButtonWidget extends StatelessWidget {
  final IconData icone;
  final String label;
  final VoidCallback onPressed;

  const RoundedButtonWidget({
    Key? key,
    required this.icone,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
              padding: const EdgeInsets.all(12.0),
              backgroundColor: const Color(0xFFFE9822),
              foregroundColor: const Color(0xFFF7A94F),
            ),
            onPressed: onPressed,
            child: Icon(
              icone,
              color: Colors.white,
              size: 30.0,
            ),
          ),
          const SizedBox(
            height: 8.0,
          ),
          Text(
            label,
            style: const TextStyle(fontSize: 12.0, color: Colors.black),
            textAlign: TextAlign.center,
            overflow: TextOverflow.clip,
          ),
        ],
      ),
    );
  }
}
