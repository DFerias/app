import 'package:app/index.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Dialogs {
  static close() {
    Navigator.pop(App.context);
  }

  static showToast(String msg) {
    Fluttertoast.showToast(
      msg: msg,
      fontSize: 14.0,
    );
  }

  static showSnackBar(BuildContext context, String message, {Color? cor}) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.fixed,
        duration: const Duration(seconds: 2),
        backgroundColor: cor,
        content: Text(
          message,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 16.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  static showLoadingDialog({String mensagem = 'Aguarde...', WillPopCallback? onPop}) {
    showDialog(
      context: App.context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: onPop ?? () async => false,
          child: Dialog(
            child: Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 12.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.all(15.0),
                    child: const CircularProgressIndicator(),
                  ),
                  Text(
                    mensagem,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  static Future showAlertDialog(String? message, String? titulo) {
    return showDialog(
      context: App.context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            titulo!,
            style: const TextStyle(color: Colors.black),
          ),
          content: SingleChildScrollView(
            child: Text(
              message!,
              style: const TextStyle(color: Colors.black, fontSize: 16.0),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Fechar'),
              onPressed: () {
                Dialogs.close();
              },
            ),
          ],
        );
      },
    );
  }
}
