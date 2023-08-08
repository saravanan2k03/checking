import 'package:checking/screen/register.dart';
import 'package:flutter/material.dart';

import '../color_and_styles.dart';
import '../functions/variables.dart';
import 'loan.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  bool hint_pass = true;
  TextEditingController username = TextEditingController();

  TextEditingController password = TextEditingController();
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
                height: size.height * 0.15,
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
                  "Login",
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
                        label: const Text("Username"),
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(14),
                        prefixIcon: Icon(
                          Icons.person,
                          color: first,
                        )),
                  )),
              SizedBox(
                height: size.height * 0.04,
              ),

              SizedBox(
                  height: size.height * 0.1,
                  width: size.width * 0.7,
                  child: TextFormField(
                    obscureText: hint_pass,
                    controller: password,
                    decoration: InputDecoration(
                        label: const Text("Password"),
                        border: const OutlineInputBorder(),
                        contentPadding: const EdgeInsets.all(14),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                hint_pass = !hint_pass;
                              });
                            },
                            icon: Icon(
                              hint_pass
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: first,
                            )),
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
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    const Text("Are you a New User ? "),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(context,
                              MaterialPageRoute(builder: (context) {
                            return const signup();
                          }));
                        },
                        child: Text(
                          "Register",
                          style: loan_details_design,
                        ))
                  ])),
              SizedBox(
                height: size.height * 0.03,
              ),
              SizedBox(
                height: size.height * 0.06,
                width: size.width * 0.7,
                child: ElevatedButton(
                  onPressed: () {
                    if (username.text.trim().isEmpty ||
                        password.text.trim().isEmpty) {
                      if (username.text.trim().isEmpty &&
                          password.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please Enter Username and Password"),
                        ));
                      } else if (username.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please Enter Username"),
                        ));
                      } else if (password.text.trim().isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Please Enter Password"),
                        ));
                      }
                    } else {
                      check_user(username.text.trim()).whenComplete(() {
                        if (user_details.isEmpty) {
                          ScaffoldMessenger.of(context)
                              .showSnackBar(const SnackBar(
                            content: Text("Invalid Username or Password"),
                          ));
                        } else {
                          if (password.text ==
                              user_details[0]["password"].toString()) {
                            store.write('id', user_details[0]["userid"]);
                            store.write('Name', user_details[0]["username"]);
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(builder: (context) {
                              return const h_screen();
                            }));
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Login Successful"),
                            ));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text("Invalid Password"),
                            ));
                          }
                        }
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(), backgroundColor: first),
                  child: const Text("Login"),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
