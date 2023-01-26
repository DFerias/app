import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:app/index.dart';

class DatePickerWidget extends StatefulWidget {
  final DateTime? date;
  final bool? dataInicio;

  const DatePickerWidget({
    Key? key,
    this.date,
    this.dataInicio,
  }) : super(key: key);

  @override
  State<DatePickerWidget> createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  @override
  Widget build(BuildContext context) {
    String? label = 'DD/MM/YYYY';
    String? dataSelecionada = DateFormat('dd/MM/yyyy').format(DateFormat('yyyy-MM-dd').parse((widget.date ?? DateTime.now()).toString()));

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 229, 218, 204),
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
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
    );
  }
}

class DateTimePicker {
  Future picker(DateTime? firstDate) async {
    DateTime? data = await DateDialog.show(DateTime.now(), firstDate);
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
