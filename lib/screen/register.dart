import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import '../color_and_styles.dart';
import 'c_register.dart';
import 'loan.dart';
import 'login.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  var c_name = null;
  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();
  TextEditingController c_password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.1,
              ),
              SizedBox(
                child: Text(
                  "Daily Thandal",
                  style: TextStyle(
                      color: first, fontWeight: FontWeight.bold, fontSize: 35),
                ),
              ),
              const SizedBox(
                child: Text(
                  "User Register",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                ),
              ),
              SizedBox(
                height: size.height * 0.06,
              ),
              SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.7,
                  child: TextFormField(
                    controller: username,
                    decoration: InputDecoration(
                        label: Text("Username"),
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
                    obscureText: true,
                    controller: password,
                    decoration: InputDecoration(
                        label: Text("Password"),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(14),
                        prefixIcon: Icon(
                          Icons.verified_user,
                          color: first,
                        )),
                  )),
              //               SizedBox(child:),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.7,
                  child: TextFormField(
                    // obscureText: true,
                    controller: c_password,
                    decoration: InputDecoration(
                        label: Text("Confirm Password"),
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.all(14),
                        prefixIcon: Icon(
                          Icons.verified_user,
                          color: first,
                        )),
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                  height: size.height * 0.08,
                  width: size.width * 0.7,
                  child: DropdownSearch(
                    popupProps: PopupProps.menu(
                      title: SizedBox(
                          child: Text(
                        """  Select Company""",
                        style: loan_details_design,
                      )),
                      showSearchBox: true,
                    ),
                    dropdownDecoratorProps: DropDownDecoratorProps(
                      dropdownSearchDecoration: InputDecoration(
                          label: Text("Company"),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey))),
                    ),
                    onChanged: (select) {
                      setState(() {
                        c_name = select;
                      });
                    },
                    items: company,
                  )),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text("New Company ? "),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return c_register();
                          }));
                        },
                        child: Text(
                          "Register Here",
                          style: loan_details_design,
                        ))
                  ])),
              // SizedBox(
              //   height: size.height * 0.02,
              // ),
              SizedBox(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Text("Already have an account ? "),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return login();
                          }));
                        },
                        child: Text(
                          "Login",
                          style: loan_details_design,
                        ))
                  ])),
              // SizedBox(
              //   height: size.height * 0.03,
              // ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) {
                      return h_screen();
                    }));
                  },
                  style: ElevatedButton.styleFrom(
                      shape: StadiumBorder(), backgroundColor: first),
                  child: const Text("Register"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
