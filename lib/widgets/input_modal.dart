
import 'package:flutter/material.dart';

class InputModal {

  static displayDialog(BuildContext context,
      {@required String title,
      @required String hintText,
      @required void Function(String) onSuccess,
      void Function() onCancel,
      String confirmButtonText = "Ok",
      String cancelButtonText = "Cancel"}) async {

    assert(title != null);
    assert(hintText != null);
    assert(onSuccess != null);

    Function _onCancel = onCancel ?? () => Navigator.of(context).pop();
    TextEditingController _textFieldController = TextEditingController();

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: TextField(
              autofocus: true,
              controller: _textFieldController,
              decoration: InputDecoration(hintText: hintText),
              textInputAction: TextInputAction.done,
              onEditingComplete: () {
                onSuccess(_textFieldController.text);
                Navigator.of(context).pop();
              },
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text(cancelButtonText),
                onPressed: () {
                  _onCancel();
                },
              ),
              new FlatButton(
                child: new Text(confirmButtonText),
                onPressed: () {
                  onSuccess(_textFieldController.text);
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }
}
