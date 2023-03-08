import 'package:flutter/material.dart';

class TextFieldObservacao extends StatefulWidget {
  final ScrollController scrollController;
  final TextEditingController textEditingController;

  const TextFieldObservacao({
    Key? key,
    required this.scrollController,
    required this.textEditingController,
  }) : super(key: key);

  @override
  State<TextFieldObservacao> createState() => _TextFieldObservacaoState();
}

class _TextFieldObservacaoState extends State<TextFieldObservacao> {
  @override
  Widget build(BuildContext context) {
    setState(() {});
    return TextFormField(
      scrollController: widget.scrollController,
      autocorrect: false,
      keyboardType: TextInputType.multiline,
      textAlignVertical: TextAlignVertical.top,
      style: TextStyle(color: Colors.grey[700]),
      textAlign: TextAlign.start,
      maxLines: null,
      maxLength: 500,
      keyboardAppearance: Brightness.dark,
      controller: widget.textEditingController,
      decoration: InputDecoration(
        filled: true,
        label: const Text('Observação'),
        contentPadding: const EdgeInsets.only(left: 5.0, bottom: 5.0, top: 5.0),
        suffixIcon: Visibility(
          visible: widget.textEditingController.text.isNotEmpty,
          child: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              widget.textEditingController.clear();
              setState(() {});
            },
          ),
        ),
      ),
      onChanged: (_) {
        setState(() {});
      },
    );
  }
}
