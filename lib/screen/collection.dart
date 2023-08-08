// ignore_for_file: non_constant_identifier_names, unused_element, prefer_interpolation_to_compose_strings, duplicate_ignore

import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:share_plus/share_plus.dart';
import '../color_and_styles.dart';
import '../functions/variables.dart';
import 'bottom_sheet.dart';
import 'constantapi.dart';
import 'dilogue.dart';
import 'drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// ignore: camel_case_types show constantapi, camel_case_types
class collection extends StatefulWidget {
  const collection({super.key});

  @override
  State<collection> createState() => _collectionState();
}

// ignore: camel_case_types
class _collectionState extends State<collection> {
  var c_type = "Daily";
  bool collectionccheck = true;
  List<dynamic> LoanTotalEmi = [];
  List<dynamic> LoanTotalAmount = [];
  TextEditingController filter = TextEditingController(text: "Today");
  var TotalAmount = "0";
  var TotalEmi = "0";
  late Timer _timer;
  bool isload = true;
  bool once = true;
  List<dynamic> userloandata = [];
  List<dynamic> FinanceArea = [[]];
  List<dynamic> jlist = [];
  List<dynamic> LoanUserData = [];
  List<dynamic> LoanCompletedata = [];
  int _selectedPanelIndex = -1;

  var Loanpayamount;

  static Future<dynamic> CompleteCollection(String Amount) async {
    final http.Response response = await http.post(
      Uri.parse('$ip/collection/CompleteCollection'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'AgentId': store.read('id').toString(),
          'collectionAmount': Amount,
        },
      ),
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("Completed");
      }
    }
  }

  GetLoanTotalEmi() async {
    String inputDateString = filter.text.trim().toString();

    // Define the date format you are using
    DateFormat dateFormat = DateFormat('dd-MM-yyyy');

    // Parse the input date string into a DateTime object
    DateTime inputDate = dateFormat.parse(inputDateString);

    // Get the date of yesterday
    DateTime yesterday = inputDate.subtract(Duration(days: 1));

    // Format the yesterday date as a string in the desired format
    String yesterdayDateString = dateFormat.format(yesterday);
    final http.Response response = await http.post(
      Uri.parse('$ip/collection/GetLoanTotalEmi'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'Type': c_type, 
          'Area': gettingareaemi,
          'userdate': yesterdayDateString,
        },
      ),
    );
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          LoanTotalEmi = jsonDecode(response.body);
          // if (kDebugMode) {
          //   print(LoanTotalEmi[0][0]["Emi"]);
          // }
          if (LoanTotalEmi[0][0]["Emi"] == "" ||
              LoanTotalEmi[0][0]["Emi"] == "0" ||
              LoanTotalEmi[0][0]["Emi"] == "null" ||
              LoanTotalEmi[0][0]["Emi"] == null) {
            TotalEmi = "0";
          } else {
            TotalEmi = LoanTotalEmi[0][0]["Emi"].toString();
          }
        });
      }
      if (kDebugMode) {
        // print("LoanTotalEmi:$LoanTotalEmi");
      }
    }
  }

  GetLoanTotalAmount() async {
    final http.Response response = await http.post(
      Uri.parse('$ip/collection/GetLoanTotalPaidAmount'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'Type': c_type,
          'Area': gettingareaemi,
        },
      ),
    );
    if (response.statusCode == 200) {
      if (mounted) {
        setState(() {
          LoanTotalAmount = jsonDecode(response.body);
          // if (kDebugMode) {
          //   print(LoanTotalAmount[0][0]["Amount"]);
          // }
          if (LoanTotalAmount[0][0]["Amount"] == "" ||
              LoanTotalAmount[0][0]["Amount"] == "0" ||
              LoanTotalAmount[0][0]["Amount"] == "null" ||
              LoanTotalAmount[0][0]["Amount"] == null) {
            TotalAmount = "0";
          } else {
            TotalAmount = LoanTotalAmount[0][0]["Amount"].toString();
          }
        });
      }
      if (kDebugMode) {
        // print("LoanTotalAmount:$LoanTotalAmount");
      }
    }
  }

  Future GetLoanUserData(String LoanCode) async {
    final http.Response response = await http.post(
      Uri.parse('$ip/collection/GetLoanuserData'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        <String, String>{
          'LoanCode': LoanCode,
        },
      ),
    );
    if (response.statusCode == 200) {
      setState(() {
        LoanUserData = jsonDecode(response.body);
      });
      if (kDebugMode) {
        //   print("LoanUserData:$LoanUserData");
      }
    }
  }

  Future LoanPayAmount(
      String LoanCode, String LoanPaidAmount, String AgentId) async {
    if (kDebugMode) {
      //  print(AgentId);
    }
    try {
      http.Response res = await http.post(
        Uri.parse('$ip/collection/PayAmount'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "LoanCode": LoanCode,
            "LoanPaidAmount": LoanPaidAmount,
            "AgentId": AgentId,
          },
        ),
      );
      if (res.statusCode == 200) {
        if (mounted) {
          setState(() {});
        }
      } else {
        if (kDebugMode) {
          print('A unknown error occured. code:${res.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future GetArea(String loanformate) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$ip/collection/GetAreaDaily'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "LoanType": loanformate,
          },
        ),
      );
      if (res.statusCode == 200) {
        setState(() {
          FinanceArea = json.decode(res.body);
        });

        if (kDebugMode) {
          // print("FinanceArea: ${FinanceArea[0]}");
        }
      } else {
        if (kDebugMode) {
          print('A unknown error occured. code:${res.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  GetLoanDetails(String LoanType, String date) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$ip/collection/GetLoanDetails'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "Type": LoanType,
            "date": date,
          },
        ),
      );
      if (res.statusCode == 200) {
        setState(() {
          jlist = json.decode(res.body);

          if (kDebugMode) {
            print(jlist);
          }

          userloandata = jlist;
        });

        if (kDebugMode) {
          print("userloandata:$userloandata");
        }
      } else {
        if (kDebugMode) {
          print('A unknown error occured. code:${res.statusCode}');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  @override
  void initState() {
    var dateFormatter = DateFormat('dd-MM-yyyy');
    var TodayDate = dateFormatter.format(DateTime.now());
    filter.text = TodayDate.toString();
    GetArea(c_type);
    GetLoanDetails(c_type, filter.text);
    constantapi().collectionchecking().whenComplete(() {
      if (kDebugMode) {
        print(isload);
      }

      _timer = Timer.periodic(
          const Duration(seconds: 3), (timer) => GetLoanTotalEmi());

      _timer = Timer.periodic(
          const Duration(seconds: 3), (timer) => GetLoanTotalAmount());
      isload = false;
    });

    super.initState();
  }

  @override
  void dispose() {
    if (_timer.isActive) _timer.cancel();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: first),
        elevation: 1,
        title: Text(
          "Collection",
          style: TextStyle(color: first),
        ),
        // centerTitle: true,
        backgroundColor: second,
      ),
      drawer: drawer(),
      body: isload
          ? Center(child: CircularProgressIndicator(color: first))
          : check_col
              ? Scrollbar(
                  interactive: true,
                  thickness: 8.0,
                  child: SingleChildScrollView(
                    child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          children: [
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SizedBox(
                              width: size.width * 0.9,
                              height: size.height * 0.05,
                              child: TextFormField(
                                readOnly: true,
                                cursorColor: first,
                                controller: filter,
                                decoration: InputDecoration(
                                    hintText: "Pick a Date",
                                    prefixIcon: const Icon(Icons.tune),
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.search),
                                      onPressed: () {
                                        GetArea(c_type);
                                        GetLoanDetails(
                                            c_type, filter.text.toString());
                                      },
                                    ),
                                    contentPadding:
                                        const EdgeInsets.only(left: 10),
                                    fillColor: Colors.white,
                                    filled: true,
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: first),
                                      borderRadius: BorderRadius.circular(10),
                                    )),
                                keyboardType: TextInputType.datetime,
                                onTap: () async {
                                  DateTime? d_pick = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2101),
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
                                              foregroundColor: first,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  var date = DateTime.parse(d_pick.toString());
                                  var dateFormatter = DateFormat('dd-MM-yyyy');
                                  var correct_format =
                                      dateFormatter.format(date);
                                  var TodayDate =
                                      dateFormatter.format(DateTime.now());
                                  filter.text = correct_format;

                                  if (kDebugMode) {
                                    print("TodayDate: $TodayDate");
                                  }
                                  GetArea(c_type);
                                  GetLoanDetails(
                                      c_type, filter.text.toString());
                                },
                              ),
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                SizedBox(
                                  height: size.height * 0.05,
                                  width: size.width * 0.5,
                                  child: RadioListTile(
                                      activeColor: first,
                                      value: "Daily",
                                      title: const Text("Daily"),
                                      groupValue: c_type,
                                      onChanged: (select) {
                                        setState(() {
                                          if (c_type == 'Weekly') {
                                            collectionccheck = true;
                                          }
                                          if (kDebugMode) {
                                            print("Daily:$collectionccheck");
                                          }
                                          c_type = select!;

                                          if (kDebugMode) {
                                            print(c_type);
                                          }
                                          GetArea(c_type);
                                          GetLoanDetails(c_type, filter.text);
                                        });
                                      }),
                                ),
                                SizedBox(
                                  height: size.height * 0.05,
                                  width: size.width * 0.5,
                                  child: RadioListTile(
                                      activeColor: first,
                                      value: "Weekly",
                                      title: const Text("weekly"),
                                      groupValue: c_type,
                                      onChanged: (select) {
                                        setState(() {
                                          if (c_type == 'Daily') {
                                            collectionccheck = false;
                                          }
                                          if (kDebugMode) {
                                            print("weekly:$collectionccheck");
                                          }
                                          c_type = select!;
                                          GetArea(c_type);
                                          GetLoanDetails(c_type, filter.text);
                                          if (kDebugMode) {
                                            print(c_type);
                                          }
                                        });
                                      }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: size.height * 0.02,
                            ),
                            SizedBox(
                              width: size.width * 0.9,
                              child: ListView.builder(
                                shrinkWrap: true,
                                physics: const BouncingScrollPhysics(),
                                itemCount: FinanceArea[0].length,
                                itemBuilder: (context, index) {
                                  var CollectionArea = FinanceArea[0][index];
                                  return Column(
                                    children: [
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      ExpansionPanelList.radio(
                                        elevation: 2,
                                        expandedHeaderPadding:
                                            const EdgeInsets.all(0),
                                        expansionCallback:
                                            (panelIndex, isExpanded) {
                                          setState(() {
                                            gettingareaemi =
                                                CollectionArea["Area"];
                                            _selectedPanelIndex =
                                                isExpanded ? -1 : panelIndex;
                                          });

                                          if (kDebugMode) {
                                            print("IN the EXpanel");
                                          }
                                          if (kDebugMode) {
                                            print(userloandata);
                                          }
                                        },
                                        initialOpenPanelValue:
                                            _selectedPanelIndex,
                                        children: [
                                          ExpansionPanelRadio(
                                            canTapOnHeader: true,
                                            value: CollectionArea["Area"],
                                            headerBuilder:
                                                ((context, isExpanded) {
                                              return Center(
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 10),
                                                      child: Text(
                                                          CollectionArea["Area"]
                                                              .toString()),
                                                    ),
                                                    CollectionArea["Totalcollection"]
                                                                .toString() ==
                                                            "null"
                                                        ? Text(
                                                            "0 / ${CollectionArea["TotalEMI"].toString()}",
                                                          )
                                                        : Text(
                                                            "${CollectionArea["Totalcollection"].toString()} / ${CollectionArea["TotalEMI"].toString()}",
                                                          ),
                                                  ],
                                                ),
                                              );
                                            }),
                                            body: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        const BouncingScrollPhysics(),
                                                    itemCount:
                                                        userloandata.length,
                                                    itemBuilder:
                                                        (context, indexs) {
                                                      final variable =
                                                          userloandata[indexs];
                                                      final vari =
                                                          variable["Area"];
                                                      var dateFormatter =
                                                          DateFormat(
                                                              'dd-MM-yyyy');
                                                      var TodayDate =
                                                          dateFormatter.format(
                                                              DateTime.now());
                                                      Loanpayamount = variable[
                                                          "PaidAmount"];

                                                      return GestureDetector(
                                                        onTap: () {
                                                          var Lcode =
                                                              variable["Lcode"];

                                                          getdate(Lcode)
                                                              .whenComplete(() {
                                                            GetLoanUserData(
                                                                    Lcode)
                                                                .whenComplete(
                                                                    () {
                                                              newMethod(
                                                                context,
                                                                size,
                                                                LoanUserData[0]
                                                                            [0]
                                                                        ["Name"]
                                                                    .toString(),
                                                                LoanUserData[0]
                                                                            [0][
                                                                        "Amount"]
                                                                    .toString(),
                                                                LoanUserData[0]
                                                                            [0][
                                                                        "Start"]
                                                                    .toString(),
                                                                LoanUserData[0]
                                                                            [0]
                                                                        ["End"]
                                                                    .toString(),
                                                                LoanUserData[0]
                                                                            [0]
                                                                        ["Due"]
                                                                    .toString(),
                                                                (int.parse(LoanUserData[0][0]
                                                                            [
                                                                            "Amount"]) -
                                                                        LoanUserData[0][0]
                                                                            [
                                                                            "Due"])
                                                                    .toString(),
                                                              );
                                                            });
                                                          });
                                                        },
                                                        child: vari ==
                                                                CollectionArea[
                                                                    "Area"]
                                                            ? Card(
                                                                elevation: 8,
                                                                child:
                                                                    SingleChildScrollView(
                                                                  scrollDirection:
                                                                      Axis.horizontal,
                                                                  child:
                                                                      Container(
                                                                    padding: EdgeInsets.all(
                                                                        size.width *
                                                                            0.025),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        SizedBox(
                                                                          child:
                                                                              Text(
                                                                            "${variable["Lcode"]} - ${variable["Name"]}",
                                                                            style:
                                                                                c_text,
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              size.height * 0.01,
                                                                        ),
                                                                        Row(
                                                                          children: [
                                                                            SizedBox(
                                                                              width: size.width * 0.3,
                                                                              child: Text(
                                                                                "Loan Amount : ${variable["Amount"]}",
                                                                                style: c_text,
                                                                              ),
                                                                            ),
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(left: 03),
                                                                              child: SizedBox(
                                                                                width: size.width * 0.3,
                                                                                child: Text(
                                                                                  "Paid Amount :",
                                                                                  style: c_text,
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: size.width * 0.2,
                                                                              height: size.height * 0.05,
                                                                              child: TextFormField(
                                                                                enabled: filter.text == TodayDate ? true : false,
                                                                                onChanged: (val) {
                                                                                  Loanpayamount = val;
                                                                                },
                                                                                cursorColor: first,
                                                                                initialValue: '${variable["PaidAmount"]}',
                                                                                // controller: myController,

                                                                                autofocus: true,
                                                                                onFieldSubmitted: (value) {
                                                                                  if (kDebugMode) {
                                                                                    print(Loanpayamount);
                                                                                  }
                                                                                  if (Loanpayamount.toString() == "" || Loanpayamount == '0' || Loanpayamount == null) {
                                                                                    setState(() {
                                                                                      Loanpayamount = variable["PaidAmount"];
                                                                                      payer(Loanpayamount, CollectionArea, indexs).whenComplete(() {
                                                                                        // ignore: duplicate_ignore
                                                                                        showDialogue(
                                                                                            context,
                                                                                            "Paid Successful",
                                                                                            // ignore: prefer_interpolation_to_compose_strings
                                                                                            "${"Paid Amount : " + Loanpayamount.toString() + ".00" + "\nPaid by : " + variable["Name"]}\nAmount collected by : " + store.read("Name"));
                                                                                      });
                                                                                    });
                                                                                  } else {
                                                                                    setState(() {
                                                                                      payer(Loanpayamount, CollectionArea, indexs).whenComplete(() {
                                                                                        // ignore: duplicate_ignore
                                                                                        showDialogue(
                                                                                            context,
                                                                                            "Paid Successful",
                                                                                            // ignore: prefer_interpolation_to_compose_strings
                                                                                            "${"Paid Amount : " + Loanpayamount.toString() + ".00" + "\nPaid by : " + variable["Name"]}\nAmount collected by : " + store.read("Name"));
                                                                                      });
                                                                                    });
                                                                                  }
                                                                                },
                                                                                decoration: InputDecoration(
                                                                                  border: OutlineInputBorder(
                                                                                    borderRadius: BorderRadius.circular(10),
                                                                                    borderSide: BorderSide(color: first),
                                                                                  ),
                                                                                  contentPadding: const EdgeInsets.only(left: 10),
                                                                                ),
                                                                                keyboardType: TextInputType.number,
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        SizedBox(
                                                                          height:
                                                                              size.height * 0.01,
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.spaceEvenly,
                                                                          children: [
                                                                            SizedBox(
                                                                              width: size.width * 0.25,
                                                                              child: Text(
                                                                                "Per Day EMI : ${variable["Emi"]}",
                                                                                style: c_text,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.035,
                                                                              width: size.width * 0.25,
                                                                              child: ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all(first),
                                                                                ),
                                                                                onPressed: () {
                                                                                  Share.share('check out my website https://example.com', subject: 'Look what I made!');
                                                                                },
                                                                                child: const Row(
                                                                                  children: [
                                                                                    Icon(
                                                                                      Icons.share,
                                                                                      size: 15,
                                                                                    ),
                                                                                    SizedBox(
                                                                                      width: 2,
                                                                                    ),
                                                                                    Text("Share"),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: size.width * 0.06,
                                                                            ),
                                                                            SizedBox(
                                                                              height: size.height * 0.035,
                                                                              width: size.width * 0.22,
                                                                              child: ElevatedButton(
                                                                                style: ButtonStyle(
                                                                                  backgroundColor: MaterialStateProperty.all(first),
                                                                                ),
                                                                                onPressed: () {
                                                                                  if (kDebugMode) {
                                                                                    print(userloandata[indexs]["PaidAmount"]);
                                                                                  }
                                                                                  setState(() {});
                                                                                  if (Loanpayamount.toString() == "" || Loanpayamount == 0 || Loanpayamount == null) {
                                                                                    if (kDebugMode) {
                                                                                      print(variable["PaidAmount"]);
                                                                                    }
                                                                                    if (kDebugMode) {
                                                                                      print("Enter into If Condition:$Loanpayamount");
                                                                                    }
                                                                                    setState(() {
                                                                                      Loanpayamount = variable["PaidAmount"];
                                                                                      payer(Loanpayamount.toString(), CollectionArea, indexs).whenComplete(() {
                                                                                        // ignore: duplicate_ignore
                                                                                        showDialogue(
                                                                                            context,
                                                                                            "Paid Successful",
                                                                                            // ignore: prefer_interpolation_to_compose_strings
                                                                                            "${"Paid Amount : " + Loanpayamount.toString() + ".00" + "\nPaid by : " + variable["Name"]}\nAmount collected by : " + store.read("Name"));
                                                                                        GetLoanDetails(c_type, filter.text);
                                                                                      });
                                                                                    });
                                                                                  } else {
                                                                                    if (kDebugMode) {
                                                                                      print("Enter into else Condition:$Loanpayamount");
                                                                                    }

                                                                                    setState(() {
                                                                                      payer(Loanpayamount.toString(), CollectionArea, indexs).whenComplete(() {
                                                                                        // ignore: duplicate_ignore
                                                                                        showDialogue(
                                                                                            context,
                                                                                            "Paid Successful",
                                                                                            // ignore: prefer_interpolation_to_compose_strings
                                                                                            "${"Paid Amount : " + Loanpayamount.toString() + ".00" + "\nPaid by : " + variable["Name"]}\nAmount collected by : " + store.read("Name"));
                                                                                        GetLoanDetails(c_type, filter.text);
                                                                                      });
                                                                                    });
                                                                                  }
                                                                                },
                                                                                child: const Text("Pay"),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Container(),
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ), ////////////////////////////////////////////////////////////////

                            const SizedBox(
                              height: 2,
                            )
                          ],
                        )),
                  ),
                )
              : Center(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Lottie.asset(
                      'Assets/completed.json',
                      width: 300,
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                    Text(
                      "Today collection is completed !",
                      style: TextStyle(
                          fontSize: 17,
                          color: first,
                          fontWeight: FontWeight.w500),
                    )
                  ],
                )),
      bottomNavigationBar: Card(
          child: SizedBox(
        height: size.height * 0.07,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: size.width * 0.3,
                child: Text(
                  "Target :  $TotalEmi",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: SizedBox(
                width: size.width * 0.3,
                child: Text(
                  "Collection : $TotalAmount",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(first),
                    shape: MaterialStateProperty.all(RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)))),
                onPressed: () {
                  check_col
                      ? col_dia(
                          context,
                        )
                      : null;
                },
                child: const Icon(Icons.handshake))
          ],
        ),
      )),
    );
  }

  Future payer(String txt, col, ind) async {
    print("txt:$txt");
    if (kDebugMode) {
      print("${userloandata[ind]["Lcode"]}");
    }
    if (txt != "") {
      var loancode = userloandata[ind]["Lcode"];
      if (kDebugMode) {
        print("LoanCode In The Payer Function :${userloandata[ind]["Lcode"]}");
      }
      LoanPayAmount(
        loancode,
        txt.toString().trim(),
        store.read("id").toString(),
      ).whenComplete(() {
        GetArea(c_type);
      });
      if (kDebugMode) {
        print("AreaData:${col["Area"].toString()}");
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10.0),
            ),
          ),
          content: Text('Please Enter Amount!'),
        ),
      );
    }
  }
}

share_text(var s_text) async {
  // await Share.share("Hello, Welcome to Daily Thundal, $s_text");
}
