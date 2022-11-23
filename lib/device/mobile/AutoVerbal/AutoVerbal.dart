<<<<<<< HEAD
import 'package:admin/device/mobile/AutoVerbal/pdf.dart';
import 'package:admin/model/models/autoVerbal.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
=======
import 'dart:typed_data';

import 'package:admin/model/models/autoVerbal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
>>>>>>> 0203833afdc6c8a3127ff772e565ef3d3d4497b2
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'package:pdf/pdf.dart';
import 'dart:convert';
<<<<<<< HEAD
=======
import 'package:pdf/pdf.dart';
>>>>>>> 0203833afdc6c8a3127ff772e565ef3d3d4497b2
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Show_autoVerbals extends StatefulWidget {
  const Show_autoVerbals({super.key});

  @override
  State<Show_autoVerbals> createState() => _Show_autoVerbalState();
}

class _Show_autoVerbalState extends State<Show_autoVerbals> {
  static int Num = 0;
  Future<List<AutoVerbal_List>> fetchData() async {
    final response = await http
        .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/autoverbal/list'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((data) => new AutoVerbal_List.fromJson(data))
          .toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

//delete id
  void deleteDataId({required String verbalIds}) async {
    final response = await http
        // ignore: unnecessary_brace_in_string_interps
        .delete(Uri.parse(
            'https://kfahrm.cc/Laravel/public/api/autoverbal/delete/${verbalIds}'));
    if (response.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text('${verbalIds['verbalId']} deleted successfully')
      //   ),
      // );
    } else {
      throw Exception('Delete error occured!');
    }
  }

<<<<<<< HEAD
  //return response;
//}
//1
=======
>>>>>>> 0203833afdc6c8a3127ff772e565ef3d3d4497b2
  List<AutoVerbal_List> data_pdf = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        title: Text(
          "AutoVerbal List",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
      ),
      body: FutureBuilder<List<AutoVerbal_List>>(
        future: fetchData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (BuildContext context, int index) {
                  final cdt = snapshot.data![index];
<<<<<<< HEAD
                  //1
                  data_pdf.add(cdt);
=======
                  data_pdf.add(cdt);
                  Num = index + 1;
>>>>>>> 0203833afdc6c8a3127ff772e565ef3d3d4497b2
                  return Container(
                      height: MediaQuery.of(context).size.height * 0.41,
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          boxShadow: [
                            BoxShadow(color: Colors.black, blurRadius: 5)
                          ]),
                      child: Column(children: [
                        Expanded(
                            flex: 4,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Code :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.verbalId.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Property Type :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.propertyTypeName.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Address :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.verbalAddress.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  14)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        flex: 2,
                                        child: Text("Bank :",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: MediaQuery.of(context)
                                                        .textScaleFactor *
                                                    15)),
                                      ),
                                      Expanded(
                                        flex: 3,
                                        child: Text(cdt.bankName.toString(),
                                            style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  12,
                                              fontWeight: FontWeight.bold,
                                            )),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Agency :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.agenttypeName.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  14)),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 4),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Create date :",
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  15)),
                                      Text(cdt.verbalCreatedDate.toString(),
                                          style: TextStyle(
                                              fontSize: MediaQuery.of(context)
                                                      .textScaleFactor *
                                                  14)),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                        const Divider(
                          color: Colors.black,
                          thickness: 3,
                          height: 2,
                          endIndent: 20,
                        ),
                        Expanded(
                          // ignore: sort_child_properties_last
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              GFButton(
                                shape: GFButtonShape.pills,
                                color: Colors.green,
                                onPressed: () {},
                                text: 'Edit',
                                icon: const Icon(Icons.edit),
                              ),
                              GFButton(
                                shape: GFButtonShape.pills,
                                color: Colors.blue,
                                onPressed: () {
                                  setState(() {
<<<<<<< HEAD
                                    _createPdf();
                                  });
                                  // Get.to(PrintPdf());
                                  // Navigator.push(
                                  //   context,
                                  //     MaterialPageRoute(builder: (context) => const Print()),
                                  //             );
                                  //Navigator.push(context, MaterialPageRoute(builder: (context) => const Print(),));
=======
                                    generatePdf();
                                    //print("go");
                                  });
>>>>>>> 0203833afdc6c8a3127ff772e565ef3d3d4497b2
                                },
                                text: 'Print',
                                icon: const Icon(Icons.print),
                              ),
                              GFButton(
                                shape: GFButtonShape.pills,
                                color: Colors.red,
                                onPressed: () {
                                  setState(() {
                                    deleteDataId(
                                        verbalIds: cdt.verbalId.toString());
                                    Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Show_autoVerbals()));
                                  });
                                },
                                text: 'Delete',
                                icon: const Icon(Icons.delete),
                              ),
                            ],
                          ),
                          flex: 1,
                        ),
                      ]));
                });
          } else if (snapshot.hasError) {
            return const Center(child: Text("Server is not responding"));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Text(Num.toString()),
      ),
    );
  }

<<<<<<< HEAD
  void _createPdf() async {
    final doc = pw.Document();

    doc.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Text('dkdkdkdkd');
      },
    ));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  //disPlay pdf
  void _displayPdf() {
    final docd = pw.Document();
    docd.addPage(pw.Page(build: (pw.Context context) {
      return pw.Center(
        child: pw.Text(
          'Hello World',
        ),
      );
    }));
    // Navigator.push(context,
    // MaterialPageRoute(builder: (context) => PreviewPdf(doc: doc),));
  }
}

class PreviewPdf extends StatelessWidget {
  final pw.Document doc;
  const PreviewPdf({super.key, required this.doc});
  void _createPdf() async {
    final doc = pw.Document();

    doc.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Text('dkdkdkdkd');
      },
    ));
    await Printing.layoutPdf(
        onLayout: (PdfPageFormat format) async => doc.save());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _bodyPdf(),
    );
  }

  Widget _bodyPdf() {
    return PdfPreview(
      build: (format) => doc.save(),
      allowPrinting: true,
      allowSharing: true,
      //initialPageFormat: PreviewPdf,
      pdfFileName: "ppppp.pdf",
    );
=======
  Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData bytes = await rootBundle.load('assets/images/KFA-Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    pdf.addPage(pw.Page(build: (context) {
      return pw.Column(children: [
        pw.Container(
          alignment: pw.Alignment.topLeft,
          height: 50,
          width: 150,
          child: pw.Image(
              pw.MemoryImage(
                byteList,
              ),
              fit: pw.BoxFit.fill),
        )
      ]);
    }));
    return pdf.save();
  }

  void generatePdf() async {
    const title = 'Flutter Demo';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
>>>>>>> 0203833afdc6c8a3127ff772e565ef3d3d4497b2
  }
}
