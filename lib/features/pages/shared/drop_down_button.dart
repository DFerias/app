import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  final Map<String, dynamic> lista;
  final String titulo;
  final String label;
  final dynamic value;
  final bool? validate;
  final String messageValidate;
  final ValueChanged onChanged;

  const DropDownButton({
    Key? key,
    required this.lista,
    required this.titulo,
    required this.label,
    this.value,
    this.validate,
    required this.messageValidate,
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.titulo,
          style: const TextStyle(
            color: Color(0xFF3F3F3F),
            fontSize: 16.0,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2.0),
        Container(
          padding: const EdgeInsets.only(bottom: 0.0),
          width: double.infinity,
          height: 54.0,
          decoration: BoxDecoration(
            color: const Color(0xFFE5DACC),
            border: Border(bottom: BorderSide(color: widget.validate == false ? Colors.red[900]! : const Color(0xFF3F3F3F))),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<dynamic>(
              borderRadius: BorderRadius.circular(5.0),
              isExpanded: true,
              hint: Padding(
                padding: const EdgeInsets.only(left: 5.0),
                child: Text(
                  widget.label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(color: widget.validate == false ? Colors.red[900] : Colors.grey[800], fontWeight: FontWeight.w500, fontSize: 15.0),
                ),
              ),
              value: widget.value,
              items: widget.lista.entries.map((MapEntry<String, dynamic> item) {
                return DropdownMenuItem(
                  value: item.key,
                  child: Tooltip(
                    message: item.value.toString(),
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
            child: Text(
              widget.messageValidate,
              style: TextStyle(
                color: Colors.red[900],
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
