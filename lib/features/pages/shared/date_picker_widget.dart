import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:app/index.dart';

class DatePickerWidget extends StatefulWidget {
  final String label;
  final DateTime? date;
  final bool? dataInicialValid;
  final bool? dataFinalValid;
  final GestureTapCallback onTap;

  const DatePickerWidget({
    Key? key,
    required this.label,
    this.date,
    this.dataInicialValid,
    this.dataFinalValid,
    required this.onTap,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    String? label = 'DD/MM/YYYY';
    String? dataSelecionada = DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse((widget.date ?? DateTime.now()).toString()));

    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: const TextStyle(
              color: Color(0xFF3F3F3F),
              fontSize: 18.0,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            decoration: BoxDecoration(
              color: const Color(0xFFE5DACC),
              borderRadius: const BorderRadius.all(Radius.circular(6.0)),
              border: Border.all(color: widget.dataInicialValid == false || widget.dataFinalValid == false ? Colors.red[900]! : const Color(0xFFE5DACC)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.date != null ? dataSelecionada : label,
                  style: TextStyle(
                    color: widget.date != null ? const Color(0xFF3F3F3F) : const Color(0x913F3F3F),
                    fontSize: 18.0,
                  ),
                ),
                const Icon(
                  Icons.calendar_month,
                  color: Color(0xFF3F3F3F),
                  size: 30.0,
                ),
              ],
            ),
          ),
          const SizedBox(height: 2.0),
          Visibility(
            visible: widget.dataInicialValid == false || widget.dataFinalValid == false,
            child: Text(
              'Campo obrigatório *',
              style: TextStyle(
                color: Colors.red[900],
                fontSize: 12.0,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DateTimePicker {
  Future picker(DateTime? firstDate, {DateTime? initial}) async {
    DateTime? data = await DateDialog.show(initial ?? DateTime.now(), firstDate);
    if (data == null) return;

    TimeOfDay? time = TimeOfDay.now();

    final dateTime = DateTime(
      data.year,
      data.month,
      data.day,
      time.hour,
      time.minute,
    );

    return dateTime;
  }
}

class DateDialog {
  static Future<DateTime?> show(DateTime initialDate, [DateTime? firstDate, DateTime? lastDate]) async {
    DateTime? date;

    await showDatePicker(
      context: App.context,
      confirmText: 'OK',
      errorFormatText: 'Formato Inválido',
      errorInvalidText: 'Período Inválido',
      initialDate: initialDate,
      firstDate: firstDate ?? DateTime.now(),
      lastDate: lastDate ?? DateTime(2040),
    ).then((value) {
      if (value != null) {
        date = value;
      } else {
        date = null;
      }
    });

    return date;
  }
}

class TimeDialog {
  static Future<TimeOfDay?> show(TimeOfDay initialTime) async {
    return await showTimePicker(
      context: App.context,
      initialTime: initialTime,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
  }
}
