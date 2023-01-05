// ignore_for_file: unnecessary_import, unused_import, camel_case_types, unnecessary_new, unnecessary_brace_in_string_interps, non_constant_identifier_names, unused_field, avoid_unnecessary_containers, prefer_const_constructors, avoid_print, unused_local_variable, unnecessary_string_interpolations, prefer_is_empty, prefer_typing_uninitialized_variables

import 'dart:typed_data';

import 'package:admin/Customs/Contants.dart';
import 'package:admin/components/get_image_by_firsbase.dart';
import 'package:admin/device/mobile/navigate_home/AutoVerbal/Deteil.dart';
import 'package:admin/device/mobile/navigate_home/AutoVerbal/Edit.dart';
import 'package:admin/device/mobile/navigate_home/AutoVerbal/Search_Screen.dart';
import 'package:admin/model/models/autoVerbal.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    final response = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list'));
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
    final response = await http.delete(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/delete/${verbalIds}'));
    if (response.statusCode == 200) {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(content: Text('${verbalIds} deleted successfully')),
      // );
    } else {
      throw Exception('Delete error occured!');
    }
  }

  int i = 0;
  static int? total_MIN = 0;
  static int? total_MAX = 0;
  List<AutoVerbal_List> data_pdf = [];
  List land = [];
  late double fsvM, fsvN, fx, fn;
  static String address = "";
  String? image_map;
  String? image;
  @override
  void initState() {
    land;
    total_MIN = 0;
    total_MAX = 0;
    data_pdf;
    fsvM = 0;
    fsvN = 0;
    fx = 0;
    fn = 0;
    image_map;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightBlue[900],
        title: const Text(
          "AutoVerbal List",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 25, color: Colors.white),
        ),
      ),
      body: Container(
        child: FutureBuilder<List<AutoVerbal_List>>(
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
                        height: MediaQuery.of(context).size.height * 0.47,
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(20),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25),
                                bottomRight: Radius.circular(25)),
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
                                                  fontSize:
                                                      MediaQuery.of(context)
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
                            thickness: 4,
                            height: 2,
                          ),
                          Expanded(
                            // ignore: sort_child_properties_last
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GFButton(
                                  shape: GFButtonShape.pills,
                                  color: const Color.fromRGBO(38, 166, 154, 1),
                                  elevation: 5,
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Detail(
                                                    id: index,
                                                    code: data_pdf
                                                        .elementAt(index)
                                                        .verbalId
                                                        .toString(),
                                                  )));
                                    });
                                  },
                                  text: 'Detail',
                                  icon: const Icon(
                                    Icons.import_contacts,
                                    color: Colors.white,
                                  ),
                                ),
                                GFButton(
                                  shape: GFButtonShape.pills,
                                  color: Color.fromRGBO(33, 57, 76, 30),
                                  elevation: 5,
                                  onPressed: () {
                                    setState(() {
                                      Navigator.of(context)
                                          .push(MaterialPageRoute(
                                              builder: (context) => Edit(
                                                    id: data_pdf
                                                        .elementAt(index)
                                                        .verbalId
                                                        .toString(),
                                                    pro: data_pdf
                                                        .elementAt(index)
                                                        .propertyTypeName
                                                        .toString(),
                                                    bn: data_pdf
                                                        .elementAt(index)
                                                        .bankAcronym
                                                        .toString(),
                                                    id_bn: data_pdf
                                                        .elementAt(index)
                                                        .bankId
                                                        .toString(),
                                                  )));
                                    });
                                  },
                                  text: 'Edit',
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                  ),
                                ),
                                GFButton(
                                  shape: GFButtonShape.pills,
                                  color: Colors.red,
                                  elevation: 5,
                                  onPressed: () {
                                    setState(() {
                                      deleteDataId(
                                          verbalIds: cdt.verbalId.toString());
                                      Navigator.pop(context);
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  Show_autoVerbals()));
                                    });
                                  },
                                  text: 'Delete',
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            ),
                            flex: 1,
                          ),
                          GFButton(
                            shape: GFButtonShape.pills,
                            color: Color.fromRGBO(33, 150, 243, 1),
                            elevation: 10.0,
                            fullWidthButton: true,
                            onPressed: () {
                              setState(() {
                                // ScaffoldMessenger.of(context).showSnackBar(
                                //   SnackBar(
                                //     duration: Duration(seconds: 15),
                                //     content: get_Map(context, index),
                                //   ),
                                // );
                                // // get_Map(context, i);
                                // print("Number of index =  ${index}");
                                // // data_pdf.add(snapshot.data![index]);

                                // for (int i = 0; i < index; i++) {
                                //   print(
                                //       "verbal ID =   ${data_pdf.elementAt(index).verbalId}\n");
                                // }
                                // total_MAX = 0;
                                // total_MIN = 0;

                                // address = "";
                                // fsvM = 0;
                                // fsvN = 0;
                                // fx = 0;
                                // fn = 0;
                                // Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         builder: (context) => OnMap()));

                                // generatePdf(index,
                                //     snapshot.data![index].verbalCon.toString());
                              });
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Get_Image_By_Firbase(
                                            com_id: snapshot
                                                .data![index].verbalId
                                                .toString(),
                                            fsv: snapshot.data![index].verbalCon
                                                .toString(),
                                            i: index,
                                          )));
                            },
                            text: 'Print',
                            icon: const Icon(
                              Icons.print,
                              color: Colors.white,
                            ),
                          ),
                        ]));
                  });
            } else if (snapshot.hasError) {
              return const Center(child: Text("Server is not responding"));
            } else {
              return Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height * 1,
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    image: const DecorationImage(
                      alignment: Alignment.center,
                      image: ExactAssetImage('assets/images/New_KFA_Logo.png'),
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  child: CircularProgressIndicator());
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue[700],
        elevation: 10,
        onPressed: () {
          // setState(() {});
          Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              return QuickSearchScreen();
            },
          ));
        },
        child: const Icon(
          Icons.search_sharp,
        ),
      ),
    );
  }

  Future<Uint8List> _generatePdf(
      PdfPageFormat format, int i, String fsv) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();
    final ByteData bytes =
        await rootBundle.load('assets/images/New_KFA_Logo.png');
    final Uint8List byteList = bytes.buffer.asUint8List();
    final ByteData bytes_image =
        await rootBundle.load('assets/images/message-banner3.jpg');
    final Uint8List byteList_image = bytes_image.buffer.asUint8List();

    pdf.addPage(pw.Page(build: (context) {
      return pw.Column(children: [
        pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
          children: [
            pw.Container(
              width: 70,
              height: 50,
              child: pw.Image(
                  pw.MemoryImage(
                    byteList,
                  ),
                  fit: pw.BoxFit.fill),
            ),
            pw.Text("VERBAL CHECK",
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            pw.Container(
              height: 50,
              width: 70,
              child: pw.BarcodeWidget(
                  barcode: pw.Barcode.qrCode(),
                  data:
                      "https://www.latlong.net/c/?lat=${data_pdf.elementAt(i).latlongLog}&long=${data_pdf.elementAt(i).latlongLa}"),
            ),
          ],
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
                        height: 25,
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
                        height: 25,
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
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: pw.EdgeInsets.all(2),
                alignment: pw.Alignment.centerLeft,
                decoration: pw.BoxDecoration(border: pw.Border.all()),
                child: pw.Text(
                    "Referring to your request letter for verbal check by ${data_pdf.elementAt(i).bankName.toString()}, we estimated the value of property as below.",
                    overflow: pw.TextOverflow.clip),
                height: 30,
                //color: Colors.blue,
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
                        height: 25,
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
                        height: 25,
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
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 6,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("${data_pdf.elementAt(i).verbalAddress}",
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 25,
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
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child:
                            // name rest with api
                            pw.Text("${data_pdf.elementAt(i).verbalOwner}",
                                style: const pw.TextStyle(fontSize: 12)),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        // name rest with api
                        child: pw.Text(
                            "Contact No : ${data_pdf.elementAt(i).verbalContact.toString()} ",
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 25,
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
                        child: pw.Text("Bank Officer ",
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 30,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("${data_pdf.elementAt(i).bankAcronym}",
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 30,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            "Contact No : ${data_pdf.elementAt(i).bankcontact.toString()}",
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
                        child: pw.Text("Latitude ",
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 3,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text("${data_pdf.elementAt(i).latlongLog}",
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 25,
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
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                    pw.Expanded(
                      flex: 2,
                      child: pw.Container(
                        padding: const pw.EdgeInsets.all(2),
                        alignment: pw.Alignment.centerLeft,
                        decoration: pw.BoxDecoration(border: pw.Border.all()),
                        child: pw.Text(
                            "${data_pdf.elementAt(i).latlongLa.toString()} ",
                            style: const pw.TextStyle(fontSize: 12)),
                        height: 25,
                        //color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 5),

              pw.Container(
                child: pw.Column(
                  children: [
                    pw.Text("ESTIMATED VALUE OF THE VERBAL CHECK PROPERTY",
                        style: const pw.TextStyle(fontSize: 12)),
                    pw.Container(
                      height: 110,
                      child: pw.Image(
                          pw.MemoryImage(
                            byteList_image,
                          ),
                          fit: pw.BoxFit.fitHeight),
                    ),
                  ],
                ),
              ),

              //After Google Map
              pw.Container(
                child: pw.Column(children: [
                  pw.Container(
                    child: pw.Row(children: [
                      pw.Expanded(
                        flex: 3,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("DESCRIPTION: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("AREA/sqm: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("MIN/sqm: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("MAX/sqm: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("MIN-VALUE:} ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("MAX-VALUE: ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                    ]),
                  ),
                  if (land.length >= 1)
                    pw.ListView.builder(
                      itemCount: land.length,
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
                                        fontSize: 10,
                                        fontWeight: pw.FontWeight.bold)),
                                height: 25,
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
                                height: 25,
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
                                    land[index]["verbal_land_minsqm"] ?? "N/A",
                                    style: pw.TextStyle(
                                        fontSize: 11,
                                        fontWeight: pw.FontWeight.bold)),
                                height: 25,
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
                                    land[index]["verbal_land_maxsqm"] ?? "N/A",
                                    style: pw.TextStyle(
                                        fontSize: 11,
                                        fontWeight: pw.FontWeight.bold)),
                                height: 25,
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
                                height: 25,
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
                                height: 25,
                                //color: Colors.blue,
                              ),
                            ),
                          ]),
                        );
                      },
                    ),
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
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(total_MIN.toString(),
                              style: pw.TextStyle(fontSize: 11)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(total_MAX.toString(),
                              style: pw.TextStyle(fontSize: 11)),
                          height: 25,
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
                          // ទាយយក forceSale from  ForceSaleAndValuation
                          child: pw.Text("Force Sale Value ${fsv}% ",
                              style: const pw.TextStyle(
                                fontSize: 11,
                              )),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(fsvN.toString(),
                              style: pw.TextStyle(fontSize: 11)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text(fsvN.toString(),
                              style: const pw.TextStyle(fontSize: 11)),
                          height: 25,
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
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("Force Sale Value: ",
                              style: const pw.TextStyle(
                                fontSize: 11,
                              )),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("$fn",
                              style: const pw.TextStyle(fontSize: 11)),
                          height: 25,
                          //color: Colors.blue,
                        ),
                      ),
                      pw.Expanded(
                        flex: 2,
                        child: pw.Container(
                          padding: const pw.EdgeInsets.all(2),
                          alignment: pw.Alignment.centerLeft,
                          decoration: pw.BoxDecoration(border: pw.Border.all()),
                          child: pw.Text("${fx}",
                              style: const pw.TextStyle(fontSize: 11)),
                          height: 25,
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
                          height: 25,
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
                          child: pw.Text(
                              "COMMENT: ${data_pdf.elementAt(i).verbalComment}",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 25,
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
                          child: pw.Text("Valuation:  ",
                              style: pw.TextStyle(
                                  fontSize: 11,
                                  fontWeight: pw.FontWeight.bold)),
                          height: 25,
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
                          height: 25,
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
        pw.SizedBox(height: 5),
        pw.Text(
            '*Note : The land building size based on the bank officer provided, in case the land and building size are wrong provided when we have the actual size inspect, we are not response on this case.'),
        pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.end,
          children: [
            pw.Row(mainAxisAlignment: pw.MainAxisAlignment.end, children: [
              pw.Text('Verbal Check Replied By :',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
              pw.Text('${data_pdf.elementAt(i).agenttypeName}',
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
            ]),
            pw.Text('${data_pdf.elementAt(i).agentTypePhone}',
                style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
          ],
        ),
        pw.Row(mainAxisAlignment: pw.MainAxisAlignment.center, children: [
          pw.Text('KHMER FOUNDATION APPRAISALS Co.,Ltd',
              style: pw.TextStyle(
                  color: PdfColors.blue,
                  fontWeight: pw.FontWeight.bold,
                  fontSize: 12)),
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
            pw.SizedBox(width: 10),
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

  void generatePdf(int i, String fsv) {
    const title = 'Flutter Demo';

    Land(data_pdf.elementAt(i).verbalId.toString(),
        data_pdf[i].verbalCon.toString());
    Future.delayed(
      const Duration(seconds: 2),
      () => Printing.layoutPdf(
          onLayout: (format) => _generatePdf(format, i, fsv)),
    );
    setState(() {
      print("========================/=================${image_map}");
      // land = [];
      // data_pdf = [];
    });
  }

  void Land(String i, String fsv) async {
    double x = 0, n = 0;
    var jsonData;
    var rs = await http.get(Uri.parse(
        'https://www.oneclickonedollar.com/laravel_kfa_2023/public/api/autoverbal/list_land?verbal_landid=$i'));
    if (rs.statusCode == 200) {
      jsonData = jsonDecode(rs.body);
      land = jsonData;
      setState(() {
        print("Land === ${land.length}");

        for (int i = 0; i < land.length; i++) {
          total_MIN = total_MIN! + int.parse(land[i]["verbal_land_minvalue"]);
          total_MAX = total_MAX! + int.parse(land[i]["verbal_land_maxvalue"]);
          // address = land[i]["address"];
          x = x + int.parse(land[i]["verbal_land_maxsqm"]);
          n = n + int.parse(land[i]["verbal_land_minsqm"]);
        }
        fsvM = (total_MAX! * double.parse(fsv)) / 100;
        fsvN = (total_MIN! * double.parse(fsv)) / 100;

        if (land.length < 1) {
          total_MIN = 0;
          total_MAX = 0;
        } else {
          fx = x * (double.parse(fsv) / 100);
          fn = n * (double.parse(fsv) / 100);
        }

        print("Total mix ${total_MAX}");
      });
    }
  }

  CollectionReference Get_Image_Map =
      FirebaseFirestore.instance.collection('Image_KFA_2@23_ON_MAP');
  CollectionReference Get_Image_Pho =
      FirebaseFirestore.instance.collection('Image_KFA_2@23');
  late Stream<QuerySnapshot> _stream;
  late Stream<QuerySnapshot> _stream1;
  Widget get_Map(BuildContext context, int index) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //Check error
        if (snapshot.hasError) {
          return Center(child: Text('Some error occurred ${snapshot.error}'));
        }

        //Check if data arrived
        if (snapshot.hasData) {
          //get the data
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot.docs;

          //Convert the documents to Maps
          List<Map> items = documents.map((e) => e.data() as Map).toList();

          //Display the list
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                //Get the item at this index
                Map thisItem = items[index];
                //REturn the widget for the list items
                if (thisItem['com_id'] == index) {
                  image_map = thisItem['image'];
                }
                return Text('');
              });
        }

        //Show loader
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget get_Image(BuildContext context, int index) {
    return StreamBuilder<QuerySnapshot>(
      stream: _stream1,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        //Check error
        if (snapshot.hasError) {
          return Center(child: Text('Some error occurred ${snapshot.error}'));
        }

        //Check if data arrived
        if (snapshot.hasData) {
          //get the data
          QuerySnapshot querySnapshot = snapshot.data;
          List<QueryDocumentSnapshot> documents = querySnapshot.docs;

          //Convert the documents to Maps
          List<Map> items = documents.map((e) => e.data() as Map).toList();

          //Display the list
          return ListView.builder(
              itemCount: items.length,
              itemBuilder: (BuildContext context, int index) {
                //Get the item at this index
                Map thisItem = items[index];
                //REturn the widget for the list items
                if (thisItem['com_id'] == index) {
                  image = thisItem['image'];
                }
                return ListTile(
                  // title: Text('${thisItem['com_id']}'),
                  subtitle: Container(
                      height: 810,
                      // width: 1080,
                      child: Image.network(
                        '${thisItem['image']}',
                        fit: BoxFit.contain,
                      )),
                  onTap: () {},
                );
              });
        }
        //Show loader
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}
