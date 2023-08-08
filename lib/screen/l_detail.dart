import 'dart:async';

import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

import '../color_and_styles.dart';
import '../functions/variables.dart';
import 'dilogue.dart';

class l_detail extends StatefulWidget {
  final String brd;
  const l_detail({super.key, required this.brd});

  @override
  State<l_detail> createState() => _l_detailState();
}

class _l_detailState extends State<l_detail> {
  DateTime selectedDate = DateTime.now();
  StreamController str2 = StreamController();
  TextEditingController l_amount = TextEditingController();
  TextEditingController l_delivery = TextEditingController();
  final _key = GlobalKey<FormState>();
  var borrower = null;
  var l_type = "Daily";
  bool _isLoading = true;
  DateTime? _selectedDate;
  DateTime? _calculatedDate;
  DateTime? _deliveredDate;

  @override
  void initState() {
    fetch_borrower().whenComplete(() {
      b_list = [];
      print(datas!.length);
      if (datas!.length != 0) {
        for (int i = 0; i < datas!.length; i++)
          [
            b_list.add(datas![i]['borrowerName'] +
                "  -  " +
                datas![i]['borrowerid'].toString()),
          ];
      } else {
        b_list = [" "];
      }
      setState(() {
        Timer(Duration(seconds: 2), () {
          setState(() {
            _isLoading = false;
          });
        });
        uid = generateCustomId();
      });
      setState(() {
        borrower = widget.brd;
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    b_list.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _key,
      appBar: AppBar(
        backgroundColor: first,
        title: Text("Enter Loan Details"),
        // centerTitle: true,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator(color: first))
          : SingleChildScrollView(
              child: Container(
                  alignment: Alignment.center,
                  child: Column(
                    children: [
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      SizedBox(
                          width: size.width * 0.9,
                          height: size.height * 0.1,
                          child: DropdownSearch(
                            selectedItem: widget.brd.toString(),
                            popupProps: PopupProps.menu(
                              showSearchBox: true,
                              title: SizedBox(
                                  child: Text("   Search Borrower",
                                      style: loan_details_design)),
                            ),
                            items: b_list,
                            dropdownDecoratorProps:
                                const DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                label: Text("Borrower"),
                                border: OutlineInputBorder(),
                                // labelText: "Borrower",
                                hintText: "Select Borrower",
                              ),
                            ),
                            onChanged: (val) {
                              setState(() {
                                borrower = val;
                              });
                            },
                          )),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: size.width * 0.45,
                              height: size.height * 0.05,
                              child: Center(child: Text("Loan ID :"))),
                          SizedBox(
                            width: size.width * 0.45,
                            height: size.height * 0.05,
                            child: Center(child: Text("${uid.toString()}")),
                          )
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: size.width * 0.45,
                              height: size.height * 0.05,
                              child: Center(
                                  child: Text("Loan Amount",
                                      style: loan_details_design))),
                          // Text("Loan Amount", style: loan_detils_design),
                          SizedBox(
                            width: size.width * 0.45,
                            height: size.height * 0.05,
                            child: TextFormField(
                              cursorColor: first,
                              controller: l_amount,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: first),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              keyboardType: TextInputType.number,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: size.width * 0.45,
                              height: size.height * 0.05,
                              child: Center(
                                  child: Text("Start Date",
                                      style: loan_details_design))),
                          // Text("Start Date", style: loan_detils_design),
                          SizedBox(
                            width: size.width * 0.45,
                            height: size.height * 0.05,
                            child: TextFormField(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                  builder: (context, child) {
                                    return Theme(
                                      data: Theme.of(context).copyWith(
                                        colorScheme: ColorScheme.light(
                                          primary: first,
                                          onPrimary: Colors.white,
                                          onSurface: Colors.black,
                                        ),
                                        textButtonTheme: TextButtonThemeData(
                                          style: TextButton.styleFrom(
                                            primary: first,
                                          ),
                                        ),
                                      ),
                                      child: child!,
                                    );
                                  },
                                ).then((value) {
                                  setState(() {
                                    _selectedDate = value;
                                    _calculatedDate =
                                        value!.add(Duration(days: 100));
                                  });
                                });
                              },
                              cursorColor: first,
                              controller: TextEditingController(
                                text: _selectedDate != null
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(_selectedDate!)
                                    : '',
                              ),
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: first),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                              keyboardType: TextInputType.datetime,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Text("End Date", style: loan_detils_design),
                          SizedBox(
                              width: size.width * 0.45,
                              height: size.height * 0.05,
                              child: Center(
                                  child: Text("End Date",
                                      style: loan_details_design))),

                          SizedBox(
                            width: size.width * 0.45,
                            height: size.height * 0.05,
                            child: TextFormField(
                              cursorColor: first,
                              controller: TextEditingController(
                                text: _calculatedDate != null
                                    ? DateFormat('dd-MM-yyyy')
                                        .format(_calculatedDate!)
                                    : '',
                              ),
                              readOnly: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  fillColor: Colors.white,
                                  filled: true,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: first),
                                    borderRadius: BorderRadius.circular(10),
                                  )),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: size.width * 0.45,
                              height: size.height * 0.05,
                              child: Center(
                                  child: Text("Loan Delivery",
                                      style: loan_details_design))),
                          // Text("Loan Amount", style: loan_detils_design),
                          SizedBox(
                              width: size.width * 0.45,
                              height: size.height * 0.05,
                              child: TextFormField(
                                cursorColor: first,
                                controller: l_delivery,
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.only(left: 10),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: first),
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                keyboardType: TextInputType.number,
                              )),
                        ],
                      ),
                      SizedBox(
                        height: size.width * 0.05,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                              width: size.width * 0.45,
                              height: size.height * 0.05,
                              child: Center(
                                  child: Text("Type of Loan",
                                      style: loan_details_design))),

                          // Text("Type of Loan", style: loan_detils_design),
                          Column(
                            children: [
                              SizedBox(
                                height: size.height * 0.05,
                                width: size.width * 0.4,
                                child: RadioListTile(
                                    activeColor: first,
                                    value: "Daily",
                                    title: Text("Daily"),
                                    groupValue: l_type,
                                    onChanged: (select) {
                                      setState(() {
                                        l_type = select!;
                                        print(l_type);
                                      });
                                    }),
                              ),
                              SizedBox(
                                height: size.height * 0.05,
                                width: size.width * 0.4,
                                child: RadioListTile(
                                  activeColor: first,
                                  selected: true,
                                  value: "Weekly",
                                  title: Text("weekly"),
                                  groupValue: l_type,
                                  onChanged: (select) {
                                    setState(() {
                                      l_type = select!;
                                      print(l_type);
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )),
            ),
      floatingActionButton: ElevatedButton(
          onPressed: () {
            if (l_amount.text == "" || l_amount.text == null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please Enter the Loan amount"),
              ));
            } else if (_selectedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please pick the Started date of loan"),
              ));
            } else if (_calculatedDate == null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please pick the Ended date of loan"),
              ));
            } else if (l_delivery.text == null || l_delivery.text == "") {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please Enter the Delivery Amount"),
              ));
            } else if (borrower == null) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Please pick the Borrower"),
              ));
            } else if (int.parse(l_amount.text) < int.parse(l_delivery.text)) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text("Delivery Amount Exceeds Loan Amount"),
              ));
            } else {
              var s_dt_ = _selectedDate.toString().split(" ")[0].split("-");
              var s_dt = s_dt_[2] + "-" + s_dt_[1] + "-" + s_dt_[0];
              var c_dt_ = _calculatedDate.toString().split(" ")[0].split("-");
              var c_dt = c_dt_[2] + "-" + c_dt_[1] + "-" + c_dt_[0];

              showConfirmationDialog(
                  context,
                  "Do you really Add Loan ?",
                  insert_Loan(
                      borrower.toString().split(" - ")[0],
                      borrower.toString().split(" - ")[1],
                      l_amount.text,
                      s_dt.toString(),
                      c_dt.toString(),
                      l_type.toString(),
                      uid.toString(),
                      l_delivery.text),
                  "Loan");
            }
          },
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
            backgroundColor: MaterialStateProperty.all(first),
          ),
          child: Text(
            "Add Loan",
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
            mobileSnackBarPosition: MobileSnackBarPosition.top)
        .show(
      context,
    );
  }
}
