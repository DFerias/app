import 'package:flutter/material.dart';

class DFeriasAppbar extends AppBar {
  DFeriasAppbar({
    super.key,
    String title = '',
    double elevation = 0,
  }) : super(
          elevation: elevation,
          centerTitle: true,
          title: Text(title),
          backgroundColor: const Color(0xFFF7EADC),
        );
}
