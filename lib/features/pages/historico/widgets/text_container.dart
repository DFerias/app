import 'package:flutter/material.dart';

class TextContainer extends StatelessWidget {
  final String label;
  final String? observacao;

  const TextContainer({
    Key? key,
    required this.label,
    this.observacao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 10.0),
            decoration: BoxDecoration(
              color: Colors.black12,
              border: Border.all(
                color: Colors.black12,
                width: 2.0,
              ),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 2.0),
                Text(
                  observacao ?? '',
                  style: const TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F)),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
