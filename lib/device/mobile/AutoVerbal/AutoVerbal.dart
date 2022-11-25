import 'dart:async';
import 'dart:typed_data';

import 'package:admin/data/data.dart';
import 'package:admin/model/models/autoVerbal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
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

  // Future<List<AutoVerbal_List>> fetchData1() async {
  //   final response = await http
  //       .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/autoverbal/type'));
  //   if (response.statusCode == 200) {
  //     List jsonResponse = json.decode(response.body);
  //     return jsonResponse
  //         .map((data1) => new AutoVerbal_List.fromJson(data1))
  //         .toList();
  //   } else {
  //     throw Exception('Unexpected error occured!');
  //   }
  // }

  Future<List<AutoVerbal_List>> datatpe() async {
    final response = await http
        .get(Uri.parse('https://kfahrm.cc/Laravel/public/api/autoverbal/type'));
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
  List land = [];
  var i = 0;
  @override
  void initState() {
    data_pdf;
    // TODO: implement initState
    super.initState();
  }

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
                  data_pdf.add(snapshot.data![index]);
                  data_pdf[index] = snapshot.data![index];
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
                                onPressed: () {
                                  // Navigator.of(context).push(MaterialPageRoute(
                                  //     builder: (context) => map()));
                                },
                                text: 'Edit',
                                icon: const Icon(Icons.edit),
                              ),
                              GFButton(
                                shape: GFButtonShape.pills,
                                color: Colors.blue,
                                onPressed: () {
                                  setState(() {
                                    print("Number of index =  ${index}");
                                    // data_pdf.add(snapshot.data![index]);

                                    for (int i = 0; i < index; i++) {
                                      print(
                                          "${data_pdf.elementAt(index).verbalId}\n");
                                    }
                                    generatePdf(index);
                                    Land(data_pdf
                                        .elementAt(index)
                                        .verbalId
                                        .toString());

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

  Future<Uint8List> _generatePdf(PdfPageFormat format, int i) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData bytes = await rootBundle.load('assets/images/KFA-Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();

    pdf.addPage(pw.Page(build: (context) {
      // pw.TableRow buildRow(List<String> cells) => pw.TableRow(
      //       children: cells.map((cell) {
      //         return pw.Padding(
      //           padding: const pw.EdgeInsets.all(12),
      //           child: pw.Center(
      //               child: pw.Text(
      //             cell,
      //             style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
      //           )),
      //         );
      //       }).toList(),
      //     );

      return pw.Column(children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              height: 50,
              width: 150,
              child: pw.Image(
                  pw.MemoryImage(
                    byteList,
                  ),
                  fit: pw.BoxFit.fill),
            ),
            pw.Container(
              height: 90,
              width: 90,
              child: pw.BarcodeWidget(
                barcode: pw.Barcode.qrCode(),
                data:
                    "https://www.latlong.net/c/?lat=${data_pdf.elementAt(i).latlongLa}&long=${data_pdf.elementAt(i).latlongLog}",
              ),
            ),
          ],
        ),
        pw.Container(
          height: 30,
          width: 100,
          child: pw.Text("VERBAL CHECK",
              style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
        ),
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
                        child: pw.Text(
                            "DATE: ${data_pdf.elementAt(i).verbalDate}",
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold)),
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
                        child: pw.Text(
                            "CODE: ${data_pdf.elementAt(i).verbalId.toString()}",
                            style: pw.TextStyle(
                                fontSize: 12, fontWeight: pw.FontWeight.bold)),
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
                        child: pw.Text(
                            "Requested Date :${data_pdf.elementAt(i).verbalCreatedDate.toString()} ",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text(
                            "Referring to your request letter for verbal check by PPCBank, we estimated the value of property as below.",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text("Property Information: ",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text(
                            "${data_pdf.elementAt(i).verbalPropertyId.toString()}",
                            style: pw.TextStyle(fontSize: 12)),
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
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("Address : ",
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 30,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            "${data_pdf.elementAt(i).verbalAddress.toString()} ",
                            style: const pw.TextStyle(fontSize: 12)),
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
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("Owner Name ",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child:
                            // name rest with api
                            pw.Text(
                                "${data_pdf.elementAt(i).verbalOwner.toString()}",
                                style: pw.TextStyle(fontSize: 12)),
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
                        // name rest with api
                        child: pw.Text(
                            "Contact No : ${data_pdf.elementAt(i).verbalContact.toString()} ",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text("Bank Officer ",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text(
                            "${data_pdf.elementAt(i).bankofficer.toString()}",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text(
                            "Contact No : ${data_pdf.elementAt(i).bankcontact.toString()}",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text("Latitude ",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text(
                            "${data_pdf.elementAt(i).latlongLa.toString()}",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text("Longtitude ",
                            style: pw.TextStyle(fontSize: 12)),
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
                        child: pw.Text(
                            "${data_pdf.elementAt(i).latlongLog.toString()} ",
                            style: pw.TextStyle(fontSize: 12)),
                        height: 30,
                        //color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 5),

              pw.Container(
                child: pw.Text("ESTIMATED VALUE OF THE VERBAL CHECK PROPERTY",
                    style: pw.TextStyle(fontSize: 15)),
              ),
              pw.SizedBox(
                height: 20,
              ),

              //After Google Map
              pw.Container(
                child: pw.Column(children: [
                  pw.Container(
                    child: pw.Row(children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("DESCRIPTION: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
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
                          child: pw.Text("AREA/sqm: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
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
                          child: pw.Text("MIN/sqm: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
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
                          child: pw.Text("MAX/sqm: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
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
                          child: pw.Text("MIN-VALUE:} ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
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
                          child: pw.Text("MAX-VALUE: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 30,
                          //color: Colors.blue,
                        ),
                      ),
                    ]),
                  ),
                  if (land.length >= 1)
                    pw.ListView.builder(
                        itemBuilder: (Context, index) {
                          return pw.Container(
                            child: pw.Row(children: [
                              pw.Expanded(
                                flex: 3,
                                child: pw.Container(
                                  padding: pw.EdgeInsets.all(2),
                                  alignment: pw.Alignment.centerLeft,
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  child: pw.Text(
                                      land[index]["verbal_land_type"] ?? "N/A",
                                      style: pw.TextStyle(
                                          fontSize: 11,
                                          fontWeight: pw.FontWeight.bold)),
                                  height: 30,
                                  //color: Colors.blue,
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: pw.EdgeInsets.all(2),
                                  alignment: pw.Alignment.centerLeft,
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  child: pw.Text(
                                      land[index]["verbal_land_area"] ?? "N/A",
                                      style: pw.TextStyle(
                                          fontSize: 11,
                                          fontWeight: pw.FontWeight.bold)),
                                  height: 30,
                                  //color: Colors.blue,
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: pw.EdgeInsets.all(2),
                                  alignment: pw.Alignment.centerLeft,
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  child: pw.Text(
                                      land[index]["verbal_land_minsqm"] ??
                                          "N/A",
                                      style: pw.TextStyle(
                                          fontSize: 11,
                                          fontWeight: pw.FontWeight.bold)),
                                  height: 30,
                                  //color: Colors.blue,
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: pw.EdgeInsets.all(2),
                                  alignment: pw.Alignment.centerLeft,
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  child: pw.Text(
                                      land[index]["verbal_land_maxsqm"] ??
                                          "N/A",
                                      style: pw.TextStyle(
                                          fontSize: 11,
                                          fontWeight: pw.FontWeight.bold)),
                                  height: 30,
                                  //color: Colors.blue,
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: pw.EdgeInsets.all(2),
                                  alignment: pw.Alignment.centerLeft,
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  child: pw.Text(
                                      land[index]["verbal_land_minvalue"] ??
                                          "N/A",
                                      style: pw.TextStyle(
                                          fontSize: 11,
                                          fontWeight: pw.FontWeight.bold)),
                                  height: 30,
                                  //color: Colors.blue,
                                ),
                              ),
                              pw.Expanded(
                                flex: 2,
                                child: pw.Container(
                                  padding: pw.EdgeInsets.all(2),
                                  alignment: pw.Alignment.centerLeft,
                                  decoration:
                                      pw.BoxDecoration(border: pw.Border.all()),
                                  child: pw.Text(
                                      land[index]["verbal_land_maxvalue"] ??
                                          "N/A",
                                      style: pw.TextStyle(
                                          fontSize: 11,
                                          fontWeight: pw.FontWeight.bold)),
                                  height: 30,
                                  //color: Colors.blue,
                                ),
                              ),
                            ]),
                          );
                        },
                        itemCount: land.length),
                  pw.Container(
                    child: pw.Row(children: [
                      pw.Expanded(
                        flex: 9,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Property Value(Estimate) ",
                              style: pw.TextStyle(
                                fontSize: 11,
                              )),
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
                          child: pw.Text("USD 0.00 ",
                              style: pw.TextStyle(fontSize: 11)),
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
                          child: pw.Text("USD 0.00 ",
                              style: pw.TextStyle(fontSize: 11)),
                          height: 30,
                          //color: Colors.blue,
                        ),
                      ),
                    ]),
                  ),
                  pw.Container(
                    child: pw.Row(children: [
                      pw.Expanded(
                        flex: 9,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Force Sale Value 30% ",
                              style: pw.TextStyle(
                                fontSize: 11,
                              )),
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
                          child: pw.Text("0.00sqm: ",
                              style: pw.TextStyle(fontSize: 11)),
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
                          child: pw.Text("USD 0.00 ",
                              style: pw.TextStyle(fontSize: 11)),
                          height: 30,
                          //color: Colors.blue,
                        ),
                      ),
                    ]),
                  ),
                  pw.Container(
                    child: pw.Row(children: [
                      pw.Expanded(
                        flex: 5,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Force Sale Value: ",
                              style: pw.TextStyle(
                                fontSize: 11,
                              )),
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
                          child: pw.Text("USD nan ",
                              style: pw.TextStyle(fontSize: 11)),
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
                          child: pw.Text("USD nan ",
                              style: pw.TextStyle(fontSize: 11)),
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
                    ]),
                  ),
                  pw.Container(
                    child: pw.Row(children: [
                      pw.Expanded(
                        flex: 11,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("COMMENT: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 30,
                          //color: Colors.blue,
                        ),
                      ),
                    ]),
                  ),
                  pw.Container(
                    child: pw.Row(children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Valuation: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
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
                    ]),
                  ),
                ]),
              ),
            ],
          ),
        ),
        pw.SizedBox(height: 10),
        pw.Text(
            '*Note : The land building size based on the bank officer provided, in case the land and building size are wrong provided when we have the actual size inspect, we are not response on this case.'),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text('Verbal Check Replied By :',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('${data_pdf.elementAt(i).verbalOwner.toString()}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ]),
            pw.SizedBox(width: 10),
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text('${data_pdf.elementAt(i).verbalContact.toString()}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ]),
          ],
        ),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.start, children: [
          pw.Text('KHMER FOUNDATION APPRAISALS Co.,Ltd',
              style: pw.TextStyle(color: PdfColors.blue)),
        ]),
        pw.Row(
          children: [
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Hotline: 077 997 888',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Row(children: [
                  pw.Text('H/P : (+855)23 988 855/(+855)23 999 761',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ]),
                pw.Row(children: [
                  pw.Text('Email : info@kfa.com.kh',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ]),
                pw.Row(children: [
                  pw.Text('Website: www.kfa.com.kh',
                      style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                ]),
              ],
            ),
            pw.SizedBox(
              width: 10,
            ),
            pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text('Villa #36A, Street No4, (Borey Peng Hout The Star',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('Natural 371) Sangkat Chak Angrae Leu,',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text('Khan Mean Chey, Phnom Penh City, Cambodia,',
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              ],
            ),
          ],
        ),
      ]);
    }));

    return pdf.save();
  }

  void generatePdf(int i) async {
    const title = 'Flutter Demo';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, i));
  }

  void Land(String i) async {
    setState(() {});
    //print(id);
    var rs = await http.get(Uri.parse(
        'https://kfahrm.cc/Laravel/public/api/autoverbal/list_land?verbal_landid=$i'));
    if (rs.statusCode == 200) {
      var jsonData = jsonDecode(rs.body);

      setState(() {
        land = jsonData;
        print("lenght =  ${land.length}");
        //print(list);
      });
    }
  }
}

// class map extends StatefulWidget {
//   const map({super.key});

//   @override
//   State<map> createState() => _mapState();
// }

// class _mapState extends State<map> {
//   // created controller for displaying Google Maps
//   Completer<GoogleMapController> _controller = Completer();

//   // given camera position
//   static final CameraPosition _kGoogle = const CameraPosition(
//     target: LatLng(19.0759837, 72.8776559),
//     zoom: 15,
//   );


//   // created empty list of markers
//   final List<Marker> _markers = <Marker>[];

//   // created list of coordinates of various locations
//   final List<LatLng> _latLen = <LatLng>[
//     LatLng(19.0759837, 72.8776559),
//     // LatLng(28.679079, 77.069710),
//     // LatLng(26.850000, 80.949997),
//     // LatLng(24.879999, 74.629997),
//     // LatLng(16.166700, 74.833298),
//     // LatLng(12.971599, 77.594563),
//   ];

//   // declared method to get Images
//   // Future<Uint8List> getImages(String path, int width) async {
//   //   ByteData data = await rootBundle.load(path);
//   //   ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
//   //       targetHeight: width);
//   //   ui.FrameInfo fi = await codec.getNextFrame();
//   //   return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!
//   //       .buffer
//   //       .asUint8List();
//   // }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     // initialize loadData method
//     loadData();
//   }

//   // created method for displaying custom markers according to index
//   loadData() async {
//     _markers.add(Marker(
//         // given marker id
//         markerId: MarkerId(0),
//         // given marker icon
//         icon: BitmapDescriptor.fromBytes(markIcons),
//         // given position
//         position: _latLen[i],
//         infoWindow: InfoWindow(
//           // given title for marker
//           title: 'Location: ' + i.toString(),
//         ),
//       ));
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Color(0xFF0F9D58),
//         // on below line we have given title of app
//         title: Text("GFG"),
//       ),
//       body: Container(
//         child: SafeArea(
//           child: GoogleMap(
//             // given camera position
//             initialCameraPosition: _kGoogle,
//             // set markers on google map
//             markers: Set<Marker>.of(_markers),
//             // on below line we have given map type
//             mapType: MapType.normal,
//             // on below line we have enabled location
//             myLocationEnabled: true,
//             myLocationButtonEnabled: true,
//             // on below line we have enabled compass
//             compassEnabled: true,
//             // below line displays google map in our app
//             onMapCreated: (GoogleMapController controller) {
//               _controller.complete(controller);
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
