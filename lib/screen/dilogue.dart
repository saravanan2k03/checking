import 'package:flutter/material.dart';

import '../color_and_styles.dart';
import '../functions/variables.dart';
import 'borrower.dart';
import 'constantapi.dart';
import 'loan.dart';

showConfirmationDialog(
    BuildContext context, String message, function, String screen) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Confirmation", style: TextStyle(color: first)),
        content: Text(message),
        actions: <Widget>[
          TextButton(
              child: Text('Yes', style: TextStyle(color: first)),
              onPressed: () {
                function;
                print(duplicate);
                if (screen == "Loan") {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => h_screen()));
                } else {
                  if (duplicate == "NO") {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => borrower()));
                  } else {
                    Navigator.of(context).pop();
                    showDialogue(
                      context,
                      "Info",
                      "Borrower is Already Exist",
                    );
                  }
                }
              }),
          TextButton(
            child: Text('No', style: TextStyle(color: first)),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future showDialogue(BuildContext context, String title, String message) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title, style: TextStyle(color: first)),
        content: Text(message),
        actions: <Widget>[
          TextButton(
            child: Text(
              'OK',
              style: TextStyle(color: first),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

col_dia(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(
          "Confirmation",
          style: TextStyle(color: first),
        ),
        content: Text("Are you completed your today collection ?"),
        actions: [
          TextButton(
            child: Text(
              "No",
              style: TextStyle(color: first),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: Text(
              "Yes",
              style: TextStyle(color: first),
            ),
            onPressed: () {
              print("ui");
              constantapi().CompleteCollection().whenComplete(() {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => const h_screen()));
                // Navigator.of(context).pop();
              });
            },
          ),
        ],
      );
    },
  );
}
