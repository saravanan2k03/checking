import 'package:checking/screen/register.dart';
import 'package:flutter/material.dart';

import '../color_and_styles.dart';

class c_register extends StatefulWidget {
  const c_register({super.key});

  @override
  State<c_register> createState() => _c_registerState();
}

class _c_registerState extends State<c_register> {
  TextEditingController c_name = TextEditingController();
  TextEditingController owner = TextEditingController();
  TextEditingController mobile = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: first,
          title: Text("Company Registration"),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.7,
                child: TextFormField(
                  controller: c_name,
                  decoration: InputDecoration(
                      label: Text("Company Name"),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(14),
                      prefixIcon: Icon(
                        Icons.apartment,
                        color: first,
                      )),
                )),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.7,
                child: TextFormField(
                  controller: owner,
                  decoration: InputDecoration(
                      label: Text("Company Owner Name"),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(14),
                      prefixIcon: Icon(
                        Icons.person,
                        color: first,
                      )),
                )),
            SizedBox(
              height: size.height * 0.02,
            ),
            SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.7,
                child: TextFormField(
                  controller: mobile,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      label: Text("Mobile Number"),
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.all(14),
                      prefixIcon: Icon(
                        Icons.person,
                        color: first,
                      )),
                )),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) {
                  return signup();
                }));
              },
              style: ElevatedButton.styleFrom(
                  backgroundColor: first, shape: StadiumBorder()),
              child: Text("Click to Register your Company"),
            ),
          ],
        )),
      ),
    );
  }
}
