import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController controllerField;
  final TextInputType keyBoardType;
  final TextInputAction textInputAction;
  final String label;
  final FormFieldValidator<String> validator;
  final bool? obscureText;
  final Widget? suffixIcon;
  final IconData? prefixIcon;

  const TextFieldWidget({
    Key? key,
    required this.controllerField,
    required this.keyBoardType,
    required this.textInputAction,
    required this.label,
    required this.validator,
    this.obscureText,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerField,
      keyboardType: keyBoardType,
      style: TextStyle(color: Colors.grey[700]),
      textInputAction: textInputAction,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      obscureText: obscureText ?? false,
      decoration: InputDecoration(
        label: Text(label),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        fillColor: const Color(0xFFE5DACC),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
        suffixIcon: suffixIcon,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: Colors.orange,
                size: 30.0,
              )
            : null,
      ),
      validator: validator,
    );
  }
}
