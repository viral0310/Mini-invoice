import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import '../constatnt/Global.dart';

class Pdf extends StatefulWidget {
  const Pdf({Key? key}) : super(key: key);

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  TextStyle tStyle = const TextStyle(fontSize: 19, fontWeight: FontWeight.w400);
  TextStyle fStyle = const TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
  TextStyle aStyle = const TextStyle(fontSize: 15);

  pw.TextStyle pwtStyle =
      pw.TextStyle(fontSize: 19, fontWeight: pw.FontWeight.bold);
  pw.TextStyle pwfStyle =
      pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold);
  pw.TextStyle pwaStyle = const pw.TextStyle(fontSize: 15);

  //final pdfSignatureImage = pw.MemoryImage(Global.signature!);
  final pdfImage = pw.MemoryImage(File(Global.image!.path).readAsBytesSync());
  final signatureImage =
      pw.MemoryImage(File(Global.SignatureImage!.path).readAsBytesSync());

  @override
  initState() {
    super.initState();
    _generatePdf();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        title: const Text("PDF"),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.pop(context);
            }),
        actions: [
          IconButton(
            onPressed: () async {
              Uint8List bytes = await Global.pdf.save();
              await Printing.layoutPdf(onLayout: (format) => bytes);
              print(Global.pdf);
              Directory? dir = await getExternalStorageDirectory();
              /*getTemporaryDirectory();*/

              // List<String> dir = List.generate(10, (index){return  getExternalStorageDirectory();});

              /* List<File> file = [];
                   file.add(dir.map((e){return File("${e!.path}/invoice.pdf");}).toList); */

              File file = File("${dir!.path}/invoice.pdf");
              print(file);
              File generateFile =
                  await file.writeAsBytes(await Global.pdf.save());
              Navigator.of(context).pushReplacementNamed('/main_page');
              setState(() {
                /*Global.pdfViewList.add(file.path);*/
                Global.pdfViewList.add(generateFile.path);
                print(Global.pdfViewList);
              });
            },
            icon: const Icon(Icons.print),
          ),
        ],
      ),
      body: Container(
        color: Colors.grey.withOpacity(0.2),
        margin: const EdgeInsets.all(15),
        padding: const EdgeInsets.all(15),
        height: double.infinity,
        width: double.infinity,
        child: getColumn(),
      ),
    );
  }

  Widget getColumn() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "INVOICE ID ${Global.invoice_Id}",
          style: tStyle,
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 80,
                      width: 80,
                      child: Image.asset(
                        'assets/Qr-Code-Background-PNG.png',
                        fit: BoxFit.cover,
                      )

                      /*Image.network(
                      'https://www.pngmart.com/files/10/Qr-Code-Background-PNG.png',
                      fit: BoxFit.cover,
                    ),*/
                      ),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Invoice No.",
                            style: fStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Invoice Date",
                            style: fStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "Invoice Due",
                            style: fStyle,
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "${Global.invoice_Id}",
                            style: aStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "${Global.date}",
                            style: aStyle,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            "15 days",
                            style: aStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                      height: 100,
                      width: 100,
                      child: (Global.image != null)
                          ? Image.file(Global.image as File)
                          : Container()),
                  /*  (Global.image != null)
                      ? Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: FileImage(Global.image as File),
                                fit: BoxFit.cover),
                          ),
                        )
                      : Container(
                          height: 100,
                          width: 100,
                        ),*/
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "${Global.business_name}",
                    style: tStyle,
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text("${Global.address}"),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          "Invoice details",
          style: fStyle,
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
                //width: 450,

                child: Row(
                  children: Global.pdftableList
                      .map(
                        (e) => Container(
                          alignment: Alignment.centerRight,
                          height: 30,
                          width: 82,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.5),
                            // border: Border.all(color: Colors.black),
                          ),
                          padding: const EdgeInsets.all(3),
                          child: Center(child: Text(e)),
                        ),
                      )
                      .toList(),
                ),
              ),
              Column(
                children: Global.item_details_list
                    .map(
                      (e) => Row(
                        children: [
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            width: 82,
                            decoration: const BoxDecoration(
                                // border: Border.all(color: Colors.black),
                                ),
                            padding: const EdgeInsets.all(8),
                            child: Center(child: Text(e.item_Name)),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            width: 82,
                            decoration: const BoxDecoration(
                                //border: Border.all(color: Colors.black),
                                ),
                            padding: const EdgeInsets.all(8),
                            child: Center(child: Text('${e.item_Cost}')),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            width: 82,
                            decoration: const BoxDecoration(
                                // border: Border.all(color: Colors.black),
                                ),
                            padding: const EdgeInsets.all(8),
                            child: Center(child: Text('${e.item_Quantity}')),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            height: 30,
                            width: 82,
                            decoration: const BoxDecoration(
                                // border: Border.all(color: Colors.black),
                                ),
                            padding: const EdgeInsets.all(8),
                            child: Center(
                              child: Text('${e.item_Cost * e.item_Quantity}'),
                            ),
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Divider(
          indent: 0,
          endIndent: 5,
          height: 4,
          thickness: 1.5,
          color: Colors.black.withOpacity(0.6),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const SizedBox(
              width: 5,
            ),
            Spacer(),
            Spacer(),
            Expanded(
              child: Column(
                children: [
                  Text("Total Cost : "),
                  Text("Cgst : "),
                  Text("Sgst : "),
                  Text("Total : "),
                ],
              ),
            ),
            Expanded(
                child: Column(
              children: [
                Text("${Global.sum} "),
                Text("${Global.cgst}"),
                Text("${Global.sgst}"),
                Text("${Global.total.toInt()}"),
              ],
            )),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Column(
              children: [
                Text(
                  "Payment Instruction",
                  style: fStyle,
                ),
                const SizedBox(
                  height: 10,
                ),
                Text("${Global.note}"),
              ],
            ),
            const SizedBox(
              width: 100,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                    height: 100,
                    width: 100,
                    child: (Global.SignatureImage != null)
                        ? Image.file(Global.SignatureImage as File)
                        : Container()),
              ],
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
          indent: 0,
          endIndent: 7,
          height: 4,
          thickness: 1.5,
          color: Colors.black.withOpacity(0.6),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(
              width: 100,
            ),
            Text(
              "Address :",
              style: fStyle,
            ),
            Text(" ${Global.address}"),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            const SizedBox(
              width: 100,
            ),
            Text(
              "Gmail :",
              style: fStyle,
            ),
            Text(" ${Global.email}"),
          ],
        ),
      ],
    );
  }

  Future<Uint8List> _generatePdf() async {
    final img = (await rootBundle.load('assets/Qr-Code-Background-PNG.png'))
        .buffer
        .asUint8List();

    Global.pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Container(
            height: 700,
            width: double.infinity,
            color: PdfColors.grey300,
            // margin: const pw.EdgeInsets.all(20),
            padding: const pw.EdgeInsets.all(30),
            child: pw.Column(
                mainAxisAlignment: pw.MainAxisAlignment.start,
                crossAxisAlignment: pw.CrossAxisAlignment.start,
                children: [
                  pw.Text(
                    "INVOICE ID ${Global.invoice_Id}",
                    style: pwtStyle,
                  ),
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.SizedBox(
                    height: 200,
                    child: pw.Row(
                      children: [
                        pw.Expanded(
                          flex: 12,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.start,
                            children: [
                              pw.SizedBox(
                                height: 70,
                                width: 70,
                                child: (img != null)
                                    ? pw.ClipRRect(
                                        horizontalRadius: 10,
                                        verticalRadius: 10,
                                        child: pw.Image(
                                          pw.MemoryImage(
                                            img,
                                          ),
                                          fit: pw.BoxFit.cover,
                                        ),
                                      )
                                    : pw.ClipRect(),
                              ),
                              pw.SizedBox(width: 20),
                              pw.Row(
                                children: [
                                  // pw.SizedBox(width: 179),
                                  pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.start,
                                    children: [
                                      pw.SizedBox(
                                        height: 10,
                                      ),
                                      pw.Text(
                                        "Invoice No.",
                                        style: pwfStyle,
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Text(
                                        "Invoice Date",
                                        style: pwfStyle,
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Text(
                                        "Invoice Due",
                                        style: pwfStyle,
                                      )
                                    ],
                                  ),
                                  pw.SizedBox(
                                    width: 5,
                                  ),
                                  pw.Column(
                                    crossAxisAlignment:
                                        pw.CrossAxisAlignment.end,
                                    children: [
                                      pw.SizedBox(
                                        height: 10,
                                      ),
                                      pw.Text(
                                        "${Global.invoice_Id}",
                                        style: pwaStyle,
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Text(
                                        "${Global.date}",
                                        style: pwaStyle,
                                      ),
                                      pw.SizedBox(
                                        height: 5,
                                      ),
                                      pw.Text(
                                        "15 days",
                                        style: pwaStyle,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        pw.Expanded(
                          flex: 2,
                          child: pw.Column(
                            crossAxisAlignment: pw.CrossAxisAlignment.end,
                            children: [
                              (pdfImage != null)
                                  ? pw.Container(
                                      height: 100,
                                      width: 150,
                                      child: pw.Image(
                                        pdfImage,
                                      ))
                                  : pw.Container(height: 100, width: 150),
                              pw.SizedBox(
                                height: 10,
                              ),
                              pw.Text(
                                "${Global.business_name}",
                                style: pwtStyle,
                              ),
                              pw.SizedBox(
                                height: 5,
                              ),
                              pw.Text("${Global.address}"),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  // row ended
                  pw.SizedBox(
                    height: 20,
                  ),
                  pw.Text(
                    "Invoice details",
                    style: pwfStyle,
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Expanded(
                    flex: 6,
                    child: pw.Container(
                      width: double.infinity,
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.center,
                        children: [
                          pw.Container(
                            height: 30,
                            //width: 450,

                            child: pw.Row(
                              children: Global.pdftableList
                                  .map(
                                    (e) => pw.Container(
                                      alignment: pw.Alignment.centerRight,
                                      height: 30,
                                      width: 103,
                                      decoration: const pw.BoxDecoration(
                                        color: PdfColors.grey,
                                        // border: Border.all(color: Colors.black),
                                      ),
                                      padding: const pw.EdgeInsets.all(3),
                                      child: pw.Center(child: pw.Text(e)),
                                    ),
                                  )
                                  .toList(),
                            ),
                          ),
                          //height: 50,
                          // width: 450,
                          pw.ListView(
                            children: Global.item_details_list
                                .map(
                                  (e) => pw.Row(
                                    children: [
                                      pw.Container(
                                        alignment: pw.Alignment.centerLeft,
                                        height: 30,
                                        width: 103,
                                        decoration: const pw.BoxDecoration(
                                            // border: Border.all(color: Colors.black),
                                            ),
                                        padding: const pw.EdgeInsets.all(8),
                                        child: pw.Center(
                                            child: pw.Text(e.item_Name)),
                                      ),
                                      pw.Container(
                                        alignment: pw.Alignment.centerLeft,
                                        height: 30,
                                        width: 103,
                                        decoration: const pw.BoxDecoration(
                                            //border: Border.all(color: Colors.black),
                                            ),
                                        padding: const pw.EdgeInsets.all(8),
                                        child: pw.Center(
                                            child: pw.Text('${e.item_Cost}')),
                                      ),
                                      pw.Container(
                                        alignment: pw.Alignment.centerLeft,
                                        height: 30,
                                        width: 103,
                                        decoration: const pw.BoxDecoration(
                                            // border: Border.all(color: Colors.black),
                                            ),
                                        padding: const pw.EdgeInsets.all(8),
                                        child: pw.Center(
                                            child:
                                                pw.Text('${e.item_Quantity}')),
                                      ),
                                      pw.Container(
                                        alignment: pw.Alignment.centerLeft,
                                        height: 30,
                                        width: 103,
                                        decoration: const pw.BoxDecoration(
                                            // border: Border.all(color: Colors.black),
                                            ),
                                        padding: const pw.EdgeInsets.all(8),
                                        child: pw.Center(
                                          child: pw.Text(
                                              '${e.item_Cost * e.item_Quantity}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                                .toList(),
                          ),
                        ],
                      ),
                    ),
                  ),

                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Divider(
                      indent: 0,
                      endIndent: 5,
                      // height: 4,
                      thickness: 1.5,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.SizedBox(
                    height: 5,
                  ),
                  pw.Expanded(
                    flex: 5,
                    child: pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.SizedBox(
                          width: 5,
                        ),
                        pw.Container(
                          height: 100,
                          width: 50,
                          child: pw.Expanded(
                            child: pw.Column(
                              children: [
                                pw.Text("Cost : "),
                                pw.Text("Cgst : "),
                                pw.Text("Sgst : "),
                                pw.Divider(thickness: 1),
                                pw.Text("Total : "),
                              ],
                            ),
                          ),
                        ),
                        pw.Container(
                          height: 100,
                          width: 50,
                          child: pw.Expanded(
                            child: pw.Column(
                              children: [
                                pw.Text("${Global.sum} "),
                                pw.Text("${Global.cgst}"),
                                pw.Text("${Global.sgst}"),
                                pw.Divider(),
                                pw.Text("${Global.total.toInt()}"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),

                    /*pw.Row(
                      mainAxisAlignment: pw.MainAxisAlignment.end,
                      children: [
                        pw.Container(
                          padding: const pw.EdgeInsets.all(8),
                          decoration: const pw.BoxDecoration(
                              border: pw.Border(
                                  bottom:
                                      pw.BorderSide(color: PdfColors.grey))),
                          child:
                              pw.Text("Total amount due       ${Global.total}"),
                        ),
                        pw.SizedBox(
                          width: 5,
                        ),
                      ],
                    ),*/
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Expanded(
                    flex: 2,
                    child: pw.Row(
                      children: [
                        pw.Column(
                          children: [
                            pw.Text(
                              "Payment Instruction",
                              style: pwfStyle,
                            ),
                            pw.SizedBox(
                              height: 10,
                            ),
                            pw.Text("${Global.note}"),
                          ],
                        ),
                        pw.SizedBox(
                          width: 150,
                        ),
                        (signatureImage != null)
                            ? pw.Container(
                                height: 70,
                                width: 150,
                                child: pw.Image(
                                  signatureImage,
                                ))
                            : pw.Container(height: 100, width: 150),
                      ],
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Expanded(
                    child: pw.Divider(
                      indent: 0,
                      endIndent: 7,
                      // height: 4,
                      thickness: 1.5,
                      color: PdfColors.black,
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      child: pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 140,
                          ),
                          pw.Text(
                            "Address :",
                            style: pwfStyle,
                          ),
                          pw.Text(" ${Global.address}"),
                        ],
                      ),
                    ),
                  ),
                  pw.SizedBox(
                    height: 10,
                  ),
                  pw.Expanded(
                    flex: 1,
                    child: pw.Container(
                      child: pw.Row(
                        children: [
                          pw.SizedBox(
                            width: 140,
                          ),
                          pw.Text(
                            "Gmail :",
                            style: pwfStyle,
                          ),
                          pw.Text(" ${Global.email}"),
                        ],
                      ),
                    ),
                  ),
                ]),
          ),
        ],
      ),
    );

    return Global.pdf.save();
  }
}
