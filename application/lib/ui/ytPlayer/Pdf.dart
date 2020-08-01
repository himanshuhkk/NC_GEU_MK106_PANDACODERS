
import 'package:flutter/material.dart';
import 'package:flutter_full_pdf_viewer/full_pdf_viewer_scaffold.dart';


class Pdf {
  final String title;
  final String image;
  final String path;

  Pdf(this.title, this.image, this.path);

  static List<Pdf> fetchAllPdfs() {
    var titles = [
      "A unique love story of Professional and Online Course",
      "Age is not an Issue",
      "Knowledge in your pocket",
      "Love Computer Science",
      "New Education Policy Highlights 2020",
    ];
    var paths = [
      "unique",
      "age",
      "knowledge",
      "cs",
      "policy",
    ];

    return List<Pdf>.generate(
      titles.length,
          (i) => Pdf(
        titles[i],
        'assets/img/${paths[i]}.jpeg',
        'assets/PDFs/${paths[i]}.pdf',
      ),
    );
  }
}

class FullPdfViewerScreen extends StatelessWidget {
  final String pdfPath;

  FullPdfViewerScreen(this.pdfPath);

  @override
  Widget build(BuildContext context) {
    return PDFViewerScaffold(
        appBar: AppBar(
          title: Text("Document"),
        ),
        path: pdfPath);
  }
}