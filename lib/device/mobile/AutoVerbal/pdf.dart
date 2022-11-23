import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class PrintPdf extends StatefulWidget {
  const PrintPdf({super.key});

  @override
  State<PrintPdf> createState() => _PrintPdfState();
}

class _PrintPdfState extends State<PrintPdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
        child: IconButton(
            onPressed: () {
              _createPdf();
            },
            icon: Icon(Icons.book)));
  }

  //Create pdf
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
  }
}
