import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  final Map<String, String>? lista;
  final String? label;
  final dynamic value;
  final bool? validate;
  final ValueChanged onChanged;

  const DropDownButton({
    Key? key,
    this.lista,
    this.label,
    this.value,
    this.validate,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String? tooltip = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 52.0,
          decoration: BoxDecoration(
            color: const Color(0xFFEDE1D3),
            border: Border(bottom: BorderSide(color: widget.validate == false ? Colors.red : const Color(0xFF3F3F3F))),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              borderRadius: BorderRadius.circular(5.0),
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(widget.label ?? '', overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.grey[700])),
              ),
              value: widget.value,
              items: widget.lista?.entries.map((MapEntry<String, String> item) {
                return DropdownMenuItem(
                  value: item.key,
                  child: Tooltip(
                    message: item.value,
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        item.key,
                        style: const TextStyle(fontSize: 17.0, color: Colors.black, overflow: TextOverflow.clip),
                      ),
                    ),
                  ),
                );
              }).toList(),
              onChanged: widget.onChanged,
            ),
          ),
        ),
        Visibility(
          visible: widget.validate == false,
          child: Container(
            padding: const EdgeInsets.only(left: 2.0, top: 8.0),
            alignment: Alignment.topLeft,
            child: const Text(
              'UF *',
              style: TextStyle(
                color: Colors.red,
                fontSize: 10.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
