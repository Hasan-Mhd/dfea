import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PdfViewerMethod extends StatelessWidget {
  final String pdfUrl;

  const PdfViewerMethod({required this.pdfUrl, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SfPdfViewer.network(
        pdfUrl,
      ),
    );
  }
}
