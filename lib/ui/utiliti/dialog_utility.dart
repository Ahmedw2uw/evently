import 'package:flutter/material.dart';

showLoading(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false, //* to cannot dismis it with out click
    builder: (context) {
      //* to bild dialog
      //* this to show dialog box in the widget
      return AlertDialog(
        //* this is alert dialog contains (title,content,button)
        content: Row(
          children: [Text("loading"), Spacer(), CircularProgressIndicator()],
        ),
      );
    },
  );
}

// hideLoading() {}

showMessage(
  BuildContext context, {
  String? title,
  String? content,
  String? posButtonTitle,
  Function? onPosButtonClick,
  String? negButtonTitle,
  Function? oNegButtonClick,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog( 
        title: title != null ? Text("$title....") : null,
        content: content != null ? Text("$content....") : null,
        actions: [
          if (posButtonTitle !=
              null) //* the if condition in the lise not but {}
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (onPosButtonClick != null) {
                  onPosButtonClick(); //*exequte thos when it not equle null
                }
              },
              child: Text(posButtonTitle),
            ),

          if (negButtonTitle != null)
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                if (oNegButtonClick != null) {
                  oNegButtonClick(); //*exequte thos when it not equle null
                }
              },
              child: Text(negButtonTitle),
            ),
        ],
      );
    },
  );
}
