import 'package:flutter/material.dart';

class Loading extends StatelessWidget {
  final String? texto;

  const Loading({Key? key, this.texto}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircularProgressIndicator(),
            Visibility(
              visible: texto != null,
              child: const SizedBox(height: 15.0),
            ),
            Visibility(
              visible: texto != null,
              child: Text(
                texto ?? '',
                style: const TextStyle(color: Colors.black),
              ),
            )
          ],
        ),
      ),
    );
  }
}
