import 'package:flutter/material.dart';

class CustomDialog extends StatelessWidget {
  final title;
  final content;
  final VoidCallback callback;
  final actionText;

  CustomDialog(this.title,this.content,this.callback,[this.actionText="RESET"]);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(title),
      content: new Text(content),
      actions: <Widget>[
        new FlatButton(
            onPressed: callback,
            color: Colors.white,
            child: new Text(actionText))
      ],
    );
  }
}
