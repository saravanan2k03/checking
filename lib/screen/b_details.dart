import 'dart:async';
import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import '../color_and_styles.dart';
import '../functions/variables.dart';
import 'dilogue.dart';

class b_detail extends StatefulWidget {
  const b_detail({super.key});

  @override
  State<b_detail> createState() => _b_detailState();
}

class _b_detailState extends State<b_detail> {
  bool _isLoading = true;
  var b_id;
  @override
  void initState() {
    b_list = ["Not Refer"];
    fetch_borrower().whenComplete(() {
      if (datas!.length != 0) {
        for (int i = 0; i < datas!.length; i++)
          [
            b_list.add(datas![i]['borrowerName'] +
                "  -  " +
                datas![i]['borrowerid'].toString()),
          ];
        b_id = datas![datas!.length - 1]["borrowerid"] + 1;
      } else {
        b_id = "1000";
      }
      setState(() {
        Timer(Duration(seconds: 2), () {
          setState(() {
            _isLoading = false;
          });
        });
      });
    });
    super.initState();
  }

  TextEditingController name = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController refer_by = TextEditingController();
  TextEditingController id_proof = TextEditingController();
  TextEditingController mob_no = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var refer = null;

  // var uid = null;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: first,
        title: Text("Enter Borrower Details"),
        // centerTitle: true,
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
              color: first,
            ))
          : Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Container(
                  alignment: Alignment.center,
                  // color: Colors.red,
                  margin: EdgeInsets.only(left: size.width * 0.1),
                  width: size.width * 0.8,
                  // height: size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: size.height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Borrower ID ", style: loan_details_design),
                          Container(
                              width: size.width * 0.45,
                              height: size.height * 0.07,
                              // color: Colors.green,
                              child: Center(child: Text("${b_id.toString()}"))),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text("Name ", style: loan_detils_design),
                          Expanded(
                            child: SizedBox(
                              // width: size.width * 0.45,
                              height: size.height * 0.07,
                              child: TextFormField(
                                cursorColor: first,
                                controller: name,
                                decoration: InputDecoration(
                                    label: Text("Name"),
                                    contentPadding: EdgeInsets.only(left: 10),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: first),
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Please Enter Borrower's Name";
                                  } else {}
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              // width: size.width * 0.45,
                              height: size.height * 0.07,
                              child: TextFormField(
                                  cursorColor: first,
                                  controller: area,
                                  decoration: InputDecoration(
                                      label: Text("Area"),
                                      contentPadding: EdgeInsets.only(left: 10),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(color: first),
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Borrower's Area";
                                    } else {}
                                    return null;
                                  }
                                  // keyboardType: TextInputType.number,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                                width: size.width * 0.9,
                                height: size.height * 0.07,
                                child: DropdownSearch(
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    title: SizedBox(
                                        child: Text("   Search Referrer",
                                            style: loan_details_design)),
                                  ),
                                  items: b_list,
                                  dropdownDecoratorProps:
                                      const DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      label: Text("Reffer by"),
                                      border: OutlineInputBorder(),
                                      // labelText: "Borrower",
                                      hintText: "Select Refferer",
                                    ),
                                  ),
                                  onChanged: (val) {
                                    setState(() {
                                      refer = val;
                                    });
                                  },
                                )),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: SizedBox(
                              // width: size.width * 0.45,
                              height: size.height * 0.07,
                              child: TextFormField(
                                  controller: id_proof,
                                  cursorColor: first,
                                  decoration: InputDecoration(
                                      label: Text("ID Proof"),
                                      contentPadding: EdgeInsets.only(left: 10),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: first,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Borrower's Id proof";
                                    } else {}
                                    return null;
                                  }
                                  // keyboardType: TextInputType.datetime,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.04,
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        children: [
                          Text(
                            "ID Proof",
                            style: loan_details_design,
                          ),
                        ],
                      ),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 178, 158, 187),
                              borderRadius: BorderRadius.circular(5)),
                          width: double.infinity,
                          height: size.height * 0.08,
                          child: const Icon(Icons.image),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text("Mobile No. ", style: loan_detils_design),
                          Expanded(
                            child: SizedBox(
                              // width: size.width * 0.45,

                              height: size.height * 0.1,
                              child: TextFormField(
                                  maxLength: 10,
                                  controller: mob_no,
                                  cursorColor: first,
                                  decoration: InputDecoration(
                                      label: const Text("Mobile No. "),
                                      contentPadding:
                                          const EdgeInsets.only(left: 10),
                                      fillColor: Colors.white,
                                      filled: true,
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color: first,
                                        ),
                                        borderRadius: BorderRadius.circular(10),
                                      )),
                                  keyboardType: TextInputType.number,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Please Enter Borrower's Mobile.No";
                                    } else {}
                                    return null;
                                  }),
                            ),
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: size.height * 0.04,
                      // ),
                      Row(
                        children: [
                          Text(
                            "Photo",
                            style: loan_details_design,
                          ),
                        ],
                      ),
                      InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 178, 158, 187),
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(Icons.image),
                          // width: size.width * 0.45,
                          width: double.infinity,
                          height: size.height * 0.08,
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.07,
                      ),
                    ],
                  ),
                ),
              ),
            ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              if (refer == null) {
                snackbar(context, "Please Pick the Referer");
              } else {
                if (refer == "Not Refer") {
                  refer = "Not Refer - N/A";
                }
                try {
                  showConfirmationDialog(
                      context,
                      "Do you really Add Borrower ?",
                      insert_Borrow(
                          name.text,
                          area.text,
                          refer.toString().split(" - ")[1].toString(),
                          id_proof.text,
                          mob_no.text),
                      "Borrower");
                } catch (ex) {
                  print(ex.toString());
                }
              }
            } else {
              return;
            }
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            backgroundColor: MaterialStateProperty.all(first),
          ),
          child: Text(
            "Add Borrower",
            style: drawer_text,
          )),
    );
  }

  snackbar(context, message) {
    AnimatedSnackBar.rectangle("All Fields are Manditory", message,
            type: AnimatedSnackBarType.warning,
            duration: Duration(seconds: 2),
            snackBarStrategy: RemoveSnackBarStrategy(),
            brightness: Brightness.dark,
            mobileSnackBarPosition: MobileSnackBarPosition.bottom)
        .show(
      context,
    );
  }
}
