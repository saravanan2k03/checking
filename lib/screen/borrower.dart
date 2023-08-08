import 'dart:async';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../color_and_styles.dart';
import '../functions/variables.dart';
import 'b_details.dart';
import 'drawer.dart';

class borrower extends StatefulWidget {
  const borrower({super.key});

  @override
  State<borrower> createState() => _borrowerState();
}

class _borrowerState extends State<borrower> {
  bool _isLoading = true;
  bool show_img = true;
  int _selectedPanelIndex = -1;
  @override
  void initState() {
    fetch_borrower().whenComplete(() {
      get_areas().whenComplete(() {
        setState(() {
          Timer(Duration(seconds: 1), () {
            setState(() {
              _isLoading = false;
            });
            setState(() {
              if (datas!.length == 0) {
                show_img = true;
              } else {
                show_img = false;
              }
              print(datas!.length);
            });
          });
        });
      });
    });
    super.initState();
  }

  Future<void> refresh() async {
    await Future.delayed(Duration(seconds: 2));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Borrower"),
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
                  builder: (context) => b_detail(),
                ));
          },
        ),
        body: _isLoading
            ? Center(
                child: CircularProgressIndicator(color: first),
              )
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
                        "No Borrower's Found!",
                        style: TextStyle(
                            fontSize: 17,
                            color: first,
                            fontWeight: FontWeight.w500),
                      )
                    ],
                  ))
                : SingleChildScrollView(
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                              width: size.width * 0.9,
                              child: RefreshIndicator(
                                color: first,
                                onRefresh: ((() => refresh())),
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: b_area.length,
                                  itemBuilder: (context, index) {
                                    return Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        ExpansionPanelList.radio(
                                          elevation: 2,
                                          expandedHeaderPadding:
                                              EdgeInsets.all(0),
                                          expansionCallback:
                                              (panelIndex, isExpanded) {
                                            setState(() {
                                              if (isExpanded) {
                                              } else {
                                                filteredData = datas
                                                    .where((data) =>
                                                        data["area"] ==
                                                        b_area[index]["area"])
                                                    .toList();
                                              }
                                            });
                                          },
                                          children: [
                                            ExpansionPanelRadio(
                                              canTapOnHeader: false,
                                              value: b_area,
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
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: //Container()
                                                            Text(b_area[index]
                                                                    ["area"]
                                                                .toString()),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: //Container()
                                                            Text(
                                                                b_area[index][
                                                                        "Count"]
                                                                    .toString(),
                                                                style: TextStyle(
                                                                    color:
                                                                        first)),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }),
                                              body: SizedBox(
                                                child: ListView.builder(
                                                    shrinkWrap: true,
                                                    physics:
                                                        NeverScrollableScrollPhysics(),
                                                    itemCount:
                                                        filteredData.length,
                                                    itemBuilder:
                                                        (context, ind) {
                                                      return Column(
                                                        children: [
                                                          SizedBox(
                                                              height:
                                                                  size.height *
                                                                      0.02),
                                                          Card(
                                                            elevation: 5,
                                                            child: Container(
                                                              padding: EdgeInsets
                                                                  .all(size
                                                                          .width *
                                                                      0.025),
                                                              color: Colors
                                                                  .grey[300],
                                                              child: Column(
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.4,
                                                                          child: Text(
                                                                              "Name : " + filteredData[ind]['borrowerName'],
                                                                              style: loan_details_design),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.4,
                                                                          child: Text(
                                                                              "Area : " + filteredData[ind]['area'].toString(),
                                                                              style: loan_details_design),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.01,
                                                                    ),
                                                                    Row(
                                                                      children: [
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.4,
                                                                          child: Text(
                                                                              "Refer By : " + filteredData[ind]['referredBy'].toString(),
                                                                              style: loan_details_design),
                                                                        ),
                                                                        SizedBox(
                                                                          width:
                                                                              size.width * 0.4,
                                                                          child: Text(
                                                                              "ID Proof: " + filteredData[ind]['IdProof'].toString(),
                                                                              style: loan_details_design),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.01,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      children: [
                                                                        SizedBox(
                                                                          child: Text(
                                                                              "Mobile : " + filteredData[ind]['mobileNumber'].toString(),
                                                                              style: loan_details_design),
                                                                        )
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.01,
                                                                    ),
                                                                    Row(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .spaceEvenly,
                                                                      children: [
                                                                        CircleAvatar(
                                                                            radius: size.width *
                                                                                0.08,
                                                                            backgroundColor:
                                                                                Colors.green[400],
                                                                            child: Icon(Icons.person)),
                                                                        CircleAvatar(
                                                                          radius:
                                                                              size.width * 0.08,
                                                                          backgroundColor:
                                                                              Colors.green[400],
                                                                          child:
                                                                              Icon(Icons.person),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    SizedBox(
                                                                      height: size
                                                                              .height *
                                                                          0.01,
                                                                    ),
                                                                  ]),
                                                            ),
                                                          )
                                                        ],
                                                      );
                                                    }),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              )),
                        ],
                      ),
                    ),
                  ));
  }
}
