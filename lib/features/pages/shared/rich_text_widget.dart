import 'package:flutter/material.dart';

class RichTextWidget extends StatelessWidget {
  final String label;
  final TextStyle? labeltextStyle;
  final String? text;
  final TextStyle? textStyle;
  final TextOverflow? overflow;

  const RichTextWidget({
    Key? key,
    required this.label,
    this.labeltextStyle,
    this.text,
    this.textStyle,
    this.overflow,
  }) : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    return RichText(
      overflow: overflow ?? TextOverflow.ellipsis,
      text: TextSpan(
        children: [
          TextSpan(
            text: '$label ',
            style: labeltextStyle ?? const TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F), fontWeight: FontWeight.bold),
          ),
          TextSpan(
            text: text,
            style: textStyle ?? const TextStyle(fontSize: 16.0, color: Color(0xFF3F3F3F)),
          )
        ],
      ),
    );
  }
}
