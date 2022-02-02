import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'constants.dart';

class AlertBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return alertPopUp(context);
  }

  static alertPopUp(context,
      {String alertTitle, String alertText, Function function}) {
    Alert(
      context: context,
      style: kAlertStyle,
      type: AlertType.info,
      title: alertTitle,
      desc: alertText,
      buttons: [
        DialogButton(
          child: Text(
            "Play Again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: function,
          color: Colors.redAccent,
          radius: BorderRadius.circular(0.0),
        ),
      ],
    ).show();
  }
}
