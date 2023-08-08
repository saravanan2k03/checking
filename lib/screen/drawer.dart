import 'package:checking/screen/report.dart';
import 'package:flutter/material.dart';

import '../color_and_styles.dart';
import '../functions/variables.dart';
import 'borrower.dart';
import 'collection.dart';
import 'loan.dart';
import 'login.dart';

class drawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: 80,
              child: ListTile(
                leading: Container(
                  decoration: BoxDecoration(
                      shape: BoxShape.circle, border: Border.all()),
                  child: Icon(
                    Icons.person_outline_outlined,
                    color: first,
                    size: 35,
                  ),
                ),
                title: Text(
                  store.read("Name").toString(),
                  style: TextStyle(color: first, fontSize: 30),
                ),
              ),
            ),
            ListTile(
              tileColor: first,
              title: Center(
                child: Text(
                  "Borrower",
                  style: drawer_text,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => borrower()));
              },
            ),
            Divider(color: second),
            ListTile(
              tileColor: first,
              title: Center(
                child: Text(
                  "Loan",
                  style: drawer_text,
                ),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => h_screen()));
              },
            ),
            Divider(color: second),
            ListTile(
              tileColor: first,
              title: Center(child: Text("Collection", style: drawer_text)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => collection()));
              },
            ),
            Divider(color: second),
            ListTile(
              tileColor: first,
              title: Center(child: Text("Report", style: drawer_text)),
              onTap: () {
                Navigator.pop(context);
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => report()));
              },
            ),
            Divider(color: second),
            ListTile(
              tileColor: first,
              title: Center(child: Text("Logout", style: drawer_text)),
              onTap: () {
                ConfirmationDialog(context);
              },
            ),
            Divider(color: second),
          ],
        ),
      ),
    );
  }

  ConfirmationDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Logout", style: TextStyle(color: first)),
          content: Text("Do you really Logout ?"),
          actions: <Widget>[
            TextButton(
                child: Text('Yes', style: TextStyle(color: first)),
                onPressed: () {
                  store.remove('Name');
                  store.remove('id');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => login()),
                    (Route<dynamic> route) => false,
                  );
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
}
