import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import '../color_and_styles.dart';
import '../functions/variables.dart';
import 'drawer.dart';
import 'loan.dart';
import 'package:pdf/widgets.dart' as pw;

class report extends StatefulWidget {
  const report({super.key});

  @override
  State<report> createState() => _reportState();
}

class _reportState extends State<report> {
  final pw.Document pdfDocument = pw.Document();
  List<List<String>> stringlist = [];
  var user = "Hello";
  TextEditingController filter = TextEditingController(text: "Today");
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report"),
        // centerTitle: true,
        backgroundColor: first,
      ),
      drawer: drawer(),
      body: Center(
        child: SingleChildScrollView(
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
                      onPressed: () {},
                    ),
                    contentPadding: const EdgeInsets.only(left: 10),
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
                              primary: first,
                            ),
                          ),
                        ),
                        child: child!,
                      );
                    },
                  );
                  var date = DateTime.parse(d_pick.toString());
                  var correct_format = "${date.day}-${date.month}-${date.year}";

                  filter.text = correct_format;
                },
              ),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Center(
              child: SizedBox(
                height: size.height * 0.1,
                width: size.width * 0.7,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: first, shape: const StadiumBorder()),
                    onPressed: () async {
                      if (filter.text == "Today") {
                        dt = date();
                      } else {
                        dt = filter.text;
                      }
                      pdf_report(dt).whenComplete(() {
                        createPdf().whenComplete(() {
                          showNotification()
                              .whenComplete(() => Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => h_screen()),
                                  ));
                        });
                      });
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.download),
                        const Text("Click To Download")
                      ],
                    )),
              ),
            )
          ],
        )),
      ),
    );
  }

  Future<void> createPdf() async {
    final List<String> headers = [
      'S.No',
      'ID',
      'Name',
      'Area',
      'Mobile Number',
      'Amount Allotted',
      'Amount Delivered',
      'Allotted Date',
      'Closing Date',
      "Day's from start date",
      'Amount to be PAID',
      'No of Days PAID',
      'Amount Paid',
      'Balance',
      'Today Collection'
    ];

    if (await Permission.storage.request().isGranted) {
      pdfDocument.addPage(pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) {
            return pw.Container(
              width: PdfPageFormat.a4.width,
              height: PdfPageFormat.a4.height,
              child: pw.Column(children: [
                pw.Center(
                    child: pw.Text("Daily Report",
                        style: pw.TextStyle(
                          color: PdfColor.fromInt(0xff4F3D56),
                          fontSize: 18,
                          fontWeight: pw.FontWeight.bold,
                        ))),
                pw.SizedBox(height: 10),
                pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
                  pw.Padding(
                      padding: pw.EdgeInsets.all(4),
                      child: pw.Text("Date: $dt",
                          style: pw.TextStyle(
                            color: PdfColor.fromInt(0xff000000),
                            fontSize: 10,
                            fontWeight: pw.FontWeight.bold,
                          )))
                ]),
                pw.SizedBox(height: 10),
                pw.Table.fromTextArray(
                  cellAlignment: pw.Alignment.center,
                  headerDecoration: const pw.BoxDecoration(
                    color: PdfColor.fromInt(0xff4F3D56),
                  ),
                  headerStyle: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    color: PdfColors.white,
                    fontSize: 4.6,
                  ),
                  headers: headers,
                  data: data_report,
                  cellStyle: const pw.TextStyle(fontSize: 6),
                  headerPadding: const pw.EdgeInsets.all(5),
                  cellPadding: const pw.EdgeInsets.all(5),
                  columnWidths: {
                    0: const pw.FixedColumnWidth(40),
                    1: const pw.FixedColumnWidth(40),
                    2: const pw.FixedColumnWidth(50),
                    3: const pw.FixedColumnWidth(50),
                    4: const pw.FixedColumnWidth(50),
                    5: const pw.FixedColumnWidth(50),
                    6: const pw.FixedColumnWidth(50),
                    7: const pw.FixedColumnWidth(50),
                    8: const pw.FixedColumnWidth(50),
                    9: const pw.FixedColumnWidth(50),
                    10: const pw.FixedColumnWidth(45),
                    11: const pw.FixedColumnWidth(45),
                    12: const pw.FixedColumnWidth(45),
                    13: const pw.FixedColumnWidth(45),
                    14: const pw.FixedColumnWidth(45),
                  },
                )
              ]),
              alignment: pw.Alignment.topLeft,
            );
          }));
      final String filename = '${generateUniqueId()}.pdf';
      final File file = File('/storage/emulated/0/Download/$filename');
      await file.writeAsBytes(await pdfDocument.save());
      print('PDF saved to ${file.path}');
    } else {
      print('Permission denied');
    }
  }

  Future<void> showNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      importance: Importance.high,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await FlutterLocalNotificationsPlugin().show(
        0,
        'Report Downloaded',
        'The Report has been downloaded successfully.',
        platformChannelSpecifics);
  }
}

date() {
  DateTime now = DateTime.now().toUtc();
  String formattedDate = DateFormat('dd-MM-yyyy').format(now);
  print(formattedDate);
  return formattedDate;
}
