import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final TextEditingController? controllerField;
  final TextInputType? keyBoardType;
  final TextInputAction? textInputAction;
  final String? label;
  final String? messageValitador;
  final bool? obscureText;
  final Widget? suffixIcon;

  const TextFieldWidget({
    Key? key,
    this.controllerField,
    this.keyBoardType,
    this.textInputAction,
    this.label,
    this.messageValitador,
    this.obscureText,
    this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controllerField,
      keyboardType: keyBoardType,
      style: TextStyle(color: Colors.grey[700]),
      textInputAction: textInputAction,
      obscureText: obscureText ?? false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        isDense: true,
        label: Text(label ?? ''),
        floatingLabelStyle: TextStyle(fontSize: 18.0, color: Colors.grey[700]),
        filled: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
        suffixIcon: suffixIcon,
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return messageValitador;
        }

        return null;
      },
    );
  }
}
