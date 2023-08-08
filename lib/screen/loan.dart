import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../color_and_styles.dart';
import '../functions/variables.dart';
import 'bottom_sheet.dart';
import 'drawer.dart';
import 'l_detail.dart';
import 'borrower.dart';

class h_screen extends StatefulWidget {
  const h_screen({super.key});

  @override
  State<h_screen> createState() => _h_screenState();
}

class _h_screenState extends State<h_screen> {
  bool _isLoading = true;
  bool show_img = true;
  @override
  Future<void> _getData() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  void initState() {
    fetch_loan().whenComplete(() {
      setState(() {
        Timer(Duration(seconds: 1), () {
          setState(() {
            _isLoading = false;
            print(show_img);
          });
          setState(() {
            if (datas1!.length == 0) {
              show_img = true;
            } else {
              show_img = false;
            }
          });
        });
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  var i = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Loan"),
          // centerTitle: true,
          backgroundColor: first,
        ),
        drawer: drawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: first,
          child: const Icon(
            Icons.add_box,
            size: 30,
          ),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => l_detail(
                          brd: '',
                        )));
          },
        ),
        body: Center(
            child: SizedBox(
                width: size.width * 0.9,
                child: SingleChildScrollView(
                  child: Column(children: [
                    SizedBox(height: size.height * 0.02),
                    Container(
                      height: size.height * 0.85,
                      child: _isLoading
                          ? Center(
                              child: CircularProgressIndicator(color: first))
                          : show_img
                              ? Center(
                                  child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Lottie.asset(
                                      'Assets/not_found.json',
                                      width: 300,
                                      height: 300,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(
                                      "No Loans Found!",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: first,
                                          fontWeight: FontWeight.w500),
                                    )
                                  ],
                                ))
                              : RefreshIndicator(
                                  color: first,
                                  onRefresh: _getData,
                                  child: ListView.builder(
                                    padding: EdgeInsets.only(bottom: 80),
                                    itemCount: datas1!.length,
                                    itemBuilder: ((context, index) {
                                      return Column(
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              getdate(datas1![index]
                                                      ["loancode"])
                                                  .whenComplete(() {
                                                newMethod(
                                                    context,
                                                    size,
                                                    datas1![index]
                                                            ["borrowerName"]
                                                        .toString(),
                                                    datas1![index]["loanAmount"]
                                                        .toString(),
                                                    datas1![index]["startDt"],
                                                    datas1![index]["endDt"],
                                                    datas1![index]
                                                            ["deliverAmount"]
                                                        .toString(),
                                                    datas1![index]["balance"]
                                                        .toString());
                                              });
                                            },
                                            child: Card(
                                              elevation: 5,
                                              child: Container(
                                                padding: EdgeInsets.all(
                                                    size.width * 0.025),
                                                color: Colors.grey[300],
                                                child: Column(children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.4,
                                                        child: Text(
                                                            "Name: " +
                                                                datas1![index][
                                                                        'borrowerName']
                                                                    .toString(),
                                                            style:
                                                                loan_details_design),
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 0.4,
                                                        child: Text(
                                                            "Loan ID : " +
                                                                datas1![index][
                                                                        "loancode"]
                                                                    .toString(),
                                                            style:
                                                                loan_details_design),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.4,
                                                        child: Text(
                                                            "Loan Amount : " +
                                                                datas1![index][
                                                                        'loanAmount']
                                                                    .toString(),
                                                            style:
                                                                loan_details_design),
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 0.4,
                                                        child: Text(
                                                            "Start Date : " +
                                                                datas1![index][
                                                                        "startDt"]
                                                                    .toString(),
                                                            style:
                                                                loan_details_design),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: size.width * 0.4,
                                                        child: Text(
                                                            "Delivery Amount : ${datas1![index]["deliverAmount"]}",
                                                            style:
                                                                loan_details_design),
                                                      ),
                                                      SizedBox(
                                                        width: size.width * 0.4,
                                                        child: Text(
                                                            "End Date : " +
                                                                datas1![index][
                                                                        "endDt"]
                                                                    .toString(),
                                                            style:
                                                                loan_details_design),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    height: size.height * 0.01,
                                                  ),
                                                  Row(
                                                    // mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      SizedBox(
                                                        child: Text(
                                                            "Mode : " +
                                                                datas1![index][
                                                                        "loanType"]
                                                                    .toString(),
                                                            style:
                                                                loan_details_design),
                                                      )
                                                    ],
                                                  ),
                                                ]),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: size.height * 0.02,
                                          )
                                        ],
                                      );
                                    }),
                                  ),
                                ),
                    )
                  ]),
                ))));
  }
}
