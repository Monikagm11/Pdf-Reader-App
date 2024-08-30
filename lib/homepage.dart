import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class PDFScreen extends StatefulWidget {
  const PDFScreen({super.key});

  @override
  State<PDFScreen> createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> {
  var color_index = 0;
  late PdfViewerController controller;
  // final UndoHistoryController _undoController = UndoHistoryController();

  OverlayEntry? overlayentry;

  GlobalKey<SfPdfViewerState> pdfview = GlobalKey();

  List<Color> highlight_color = [
    Colors.black,
    Colors.red,
    Colors.orange,
    Colors.green,
    Colors.blue,
    Colors.yellow
  ];
  @override
  void initState() {
    // TODO: implement initState
    controller = PdfViewerController();
    controller.annotationSettings.highlight.color =
        highlight_color[color_index];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('PDF Viewer')),
        body: Column(
          children: [
            SizedBox(
                width: double.infinity,
                height: 600,
                child: SfPdfViewer.network(
                    //undoController: _undoController,
                    key: pdfview,
                    controller: controller,
                    onTextSelectionChanged: (details) => showMenu(
                            // constraints: const BoxConstraints(
                            //     maxHeight: 50, maxWidth: 300),
                            color: Colors.white,
                            context: context,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(100)),
                            position: RelativeRect.fromLTRB(
                              details.globalSelectedRegion!.left,
                              details.globalSelectedRegion!.top + 20,
                              0,
                              0,
                            ),
                            items: [
                              PopupMenuItem(
                                child: SizedBox(
                                  width: 250,
                                  height: 40,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            List<Annotation> annotations =
                                                controller.getAnnotations();
                                            Annotation firstAnnotation =
                                                annotations.first;

                                            setState(() {
                                              controller.removeAnnotation(
                                                  firstAnnotation);
                                            });
                                          },
                                          icon: const Icon(
                                            Icons.undo,
                                            color: Colors.red,
                                          )),
                                      ListView.separated(
                                          scrollDirection: Axis.horizontal,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) =>
                                              InkWell(
                                                  onTap: () {
                                                    setState(() {
                                                      debugPrint("index$index");
                                                      color_index = index;
                                                      controller
                                                              .annotationSettings
                                                              .highlight
                                                              .color =
                                                          highlight_color[
                                                              index];
                                                      debugPrint(
                                                          "color_inde$color_index");
                                                      final List<PdfTextLine>?
                                                          textLines = pdfview
                                                              .currentState
                                                              ?.getSelectedTextLines();

                                                      controller.addAnnotation(
                                                          HighlightAnnotation(
                                                              textBoundsCollection:
                                                                  textLines!));
                                                    });
                                                  },
                                                  child: Icon(Icons.circle,
                                                      color: highlight_color[
                                                          index],
                                                      size: 28)),
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                width: 2,
                                              ),
                                          itemCount: highlight_color.length),
                                    ],
                                  ),
                                ),
                              )
                            ]),
                    canShowTextSelectionMenu: false,
                    'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'))
          ],
        ));
  }
}
