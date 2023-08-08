import 'package:flutter/material.dart';

import '../color_and_styles.dart';
import '../functions/variables.dart';

Future<dynamic> newMethod(BuildContext context, Size size, name, loan_amt,
    start_dt, end_dt, deliveryamount, balance) {
  return showModalBottomSheet(
      context: context,
      builder: (context) {
        return SingleChildScrollView(
          // color: Colors.green,
          child: Column(
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                child: Text(
                  "Name : " + name,
                  style: loan_details_design,
                ),
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                  child: Text(
                "Loan Amount : " + loan_amt,
                style: loan_details_design,
              )),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                  child: Text(
                "Delivery Amount : " + deliveryamount,
                style: loan_details_design,
              )),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                  child: Text(
                "Given On : " + start_dt,
                style: loan_details_design,
              )),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                  child: Text(
                "Amount Due : " + balance,
                style: loan_details_design,
              )),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                  child: Text(
                "End Date : " + end_dt,
                style: loan_details_design,
              )),
              SizedBox(
                height: size.height * 0.02,
              ),
              SizedBox(
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(children: [
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                    Container(
                      height: 100,
                      child: Column(
                        children: [
                          Text("Total Amount", style: loan_details_design),
                          Amount(size, loan_amt, Colors.green[400]),
                          Text(start_dt,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width / 1.36,
                      height: 100,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          itemCount: dates!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.only(left: 4.0, right: 4),
                              child: Column(children: [
                                if (dates![index]["LoanPaidAmount"] == "0" ||
                                    dates![index]["LoanPaidAmount"] == 0)
                                  Column(
                                    children: [
                                      Text("Due ${dates!.length - index}",
                                          style: loan_details_design),
                                      Amount(
                                          size,
                                          dates![index]["LoanPaidAmount"],
                                          Colors.red[400]),
                                    ],
                                  )
                                else
                                  Column(
                                    children: [
                                      Text("Due ${dates!.length - index}",
                                          style: loan_details_design),
                                      Amount(
                                          size,
                                          dates![index]["LoanPaidAmount"],
                                          Colors.green[400]),
                                    ],
                                  ),
                                Text(
                                  dates![index]["Date"],
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                )
                              ]),
                            );
                          }),
                    ),
                    SizedBox(
                      width: size.width * 0.03,
                    ),
                  ]),
                ),
              ),
            ],
          ),
        );
      });
}

CircleAvatar Amount(Size size, text, color) {
  return CircleAvatar(
      radius: size.width * 0.08,
      backgroundColor: color,
      child: Text(text.toString(), style: drawer_text));
}
