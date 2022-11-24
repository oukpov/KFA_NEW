import 'dart:typed_data';

import 'package:admin/model/models/autoVerbal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class Show_autoVerbals extends StatefulWidget {
  const Show_autoVerbals({super.key});

  @override
  State<Show_autoVerbals> createState() => _Show_autoVerbalState();
}

class _Show_autoVerbalState extends State<Show_autoVerbals> {
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
                  data_pdf.add(cdt);
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
                                    generatePdf();
                                    //print("go");
                                  });
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
    );
  }

Future<Uint8List> _generatePdf(PdfPageFormat format, String title) async{
final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
final font = await PdfGoogleFonts.nunitoExtraLight();
final ByteData bytes = await rootBundle.load('assets/images/KFA-Logo.png');
final Uint8List byteList = bytes.buffer.asUint8List();

pdf.addPage(
  pw.Page(build: (context) {
    pw.TableRow buildRow(List<String> cells) => pw.TableRow(
      children: cells.map((cell){
       
        return pw.Padding(
          padding: const pw.EdgeInsets.all(12),
          child: pw.Center(
            child: pw.Text(cell,style: pw.TextStyle(fontWeight: pw.FontWeight.bold),)),
          );
      }).toList(),
    );
    return pw.Column(
      children: [
       pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.start,
        children: [
          pw.Container(
          alignment: pw.Alignment.topLeft,
          height: 50,
          width: 150,
          child: pw.Image(
              pw.MemoryImage(
                byteList,
              ),
              fit: pw.BoxFit.fill),
        ),
        ],
       ),
      pw.SizedBox(
        child: pw.FittedBox(
          child: pw.Text(title,style: pw.TextStyle(font: font,fontWeight: pw.FontWeight.bold,fontSize: 18))
        )
        ),
        pw.SizedBox(height: 20),
        pw.Container(
         // pw.padding: const EdgeInsets.all(9),
      child: pw.Column(
        children: [
          pw.Container(
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 4,
                  child: pw.Container(
                     padding: pw.EdgeInsets.all(2),
                    alignment: pw.Alignment.centerLeft,
                     decoration: pw.BoxDecoration(border: pw.Border.all()),
                    //color: Colors.red,
                    child: pw.Text("DATE: ",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
                    height: 30,
                    //color: Colors.white,
                  ),
                ),
                pw.Expanded(
            flex: 4,
            child: pw.Container(
              padding: pw.EdgeInsets.all(2),
              alignment: pw.Alignment.centerLeft,
              decoration: pw.BoxDecoration(border: pw.Border.all()),
              child: pw.Text("CODE: ",style: pw.TextStyle(fontSize: 12,fontWeight: pw.FontWeight.bold)),
              height: 30,
              //color: Colors.yellow,
            ),
            )
              ],
            ),
          ),
          pw.SizedBox(
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 8,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Requested Date: ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 8,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Requested Date: ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Property Information: ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 6,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Building ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Address ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 6,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(",, ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Owner Name ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("N/A ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Contact No. ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Bank Officer ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("N/A ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Contact No",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(
            child: pw.Row(
              children: [
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Latitude ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("11.5489 ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Longtitude ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Requested Date: ",style: pw.TextStyle(fontSize: 12)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
          pw.SizedBox(height: 5),
          pw.Container(
            child: pw.Text("ESTIMATED VALUE OF THE VERBAL CHECK PROPERTY",style: pw.TextStyle(fontSize: 15)),
          ),
          pw.SizedBox(height: 5),

          //After Google Map
          pw.Container(
            child: pw.Column(
              children: [
                pw.Container(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("DESCRIPTION: ",style: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("AREA/sqm: ",style: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("MIN/sqm: ",style: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("MAX/sqm: ",style: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("MIN-VALUE: ",style: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("MAX-VALUE: ",style: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                    ]
                    ),
                ),

              pw.Container(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                  flex: 9,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Property Value(Estimate) ",style: pw.TextStyle(fontSize: 11,)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("USD 0.00 ",style: pw.TextStyle(fontSize: 11)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("USD 0.00 ",style: pw.TextStyle(fontSize: 11)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                    ]
                    ),
                ),
                pw.Container(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                  flex: 9,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Force Sale Value 30% ",style: pw.TextStyle(fontSize: 11,)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: const pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("USD 0.00 ",style: const pw.TextStyle(fontSize: 11)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("USD 0.00 ",style: pw.TextStyle(fontSize: 11)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                    ]
                    ),
                ),
                              
              pw.Container(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                  flex: 5,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Force Sale Value: ",style: pw.TextStyle(fontSize: 11,)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("USD nan ",style: pw.TextStyle(fontSize: 11)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 2,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("USD nan ",style: pw.TextStyle(fontSize: 11)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                pw.Expanded(
                  flex: 4,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          //child: pw.Text("USD 0.00 ",style: pw.TextStyle(fontSize: 11)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                    ]
                    ),
                ),
                pw.Container(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                  flex: 11,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("COMMENT: ",style: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                 ),
                    ]
                    ),
                ),
                pw.Container(
                  child: pw.Row(
                    children: [
                      pw.Expanded(
                  flex: 3,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Valuation: ",style: pw.TextStyle(fontSize: 11,fontWeight: pw.FontWeight.bold)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                 pw.Expanded(
                  flex: 9,
                  child: pw.Container(
                    padding: pw.EdgeInsets.all(2),
                      alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                          //child: pw.Text("0.00sqm: ",style: pw.TextStyle(fontSize: 11)),
                            height: 30,
                    //color: Colors.blue,
                  ),
                ),
                    ]
                    ),
                ),
              ]
              ),
          ),
        ],
      ),
        )
        // pw.Flexible(
        //   child: pw.Table(
        //   border: pw.TableBorder.all(),
        //   columnWidths: const <int, pw.TableColumnWidth> {
        //   0: pw.FractionColumnWidth(0.2),
        //   // 1: pw.FractionColumnWidth(0.3),
        //   // 2: pw.FractionColumnWidth(0.3),
        //   },
        //   children: [
        //     buildRow(['Date: ','Code: ',' ','Name: ']),
        //     buildRow(['Cell 1','Cell 2',' ', 'Cell 3']),
        //     buildRow(['Cell 1','Cell 2',' ', 'Cell 3']),
        //   ],
        // ),
        // ),
    ]
    );
    
  }
  
  )
);

return pdf.save();
}

  void generatePdf() async {
    const title = 'Check Verbal';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
  }
  
}
