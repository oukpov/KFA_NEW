
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/shape/gf_button_shape.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
class DeleteId extends StatefulWidget {
  const DeleteId({super.key});

  @override
  State<DeleteId> createState() => _DeleteIdState();
}

class _DeleteIdState extends State<DeleteId> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
       child: GFButton(
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
      ),
    );
  }

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
        ),
        pw.Container(
          alignment: pw.Alignment.center,
          height: 50,
          // width: 150,
          child: pw.Text('Check Verbal',
          //style: TextStyle(color: Colors.amber,fontSize: 15),
          )
        ),
        pw.Container(
          alignment: pw.Alignment.centerRight,
          height: 50,
          child: pw.Table(
            //border: TableBorder.all();
            children: [
              
            ]
            )
        )
       // )
      ]);
    }));
    return pdf.save();
  }

  void generatePdf() async {
    const title = 'Flutter Demo';
    await Printing.layoutPdf(onLayout: (format) => _generatePdf(format, title));
  }
}