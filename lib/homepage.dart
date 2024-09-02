import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_windowmanager/flutter_windowmanager.dart';
import 'package:free_english_dictionary/free_english_dictionary.dart';
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

  String? wordmeaning;

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
    super.initState();
    controller = PdfViewerController();
    controller.annotationSettings.highlight.color =
        highlight_color[color_index];
    FlutterWindowManager.addFlags(FlutterWindowManager.FLAG_SECURE);
  }

  Future<dynamic> dictionary(String selectedtext) async {
    var text = await FreeDictionary.getWordMeaning(word: selectedtext);

    debugPrint(
        "text : ${text.first.meanings!.first.definitions!.first.definition}");
    wordmeaning = text.first.meanings!.first.definitions!.first.definition;

    BotToast.showText(
      text: "Word meaning: ${wordmeaning.toString()}",
      duration: const Duration(seconds: 3),
      align: Alignment.topCenter,
    );

    //     MaterialPageRoute(
    //       builder: (context) => const Tt(),
    //     ));
    // return wordmeaning;
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
                child: SfPdfViewer.network(key: pdfview, controller: controller,
                    onTextSelectionChanged: (details) {
                  print(details.selectedText);
                  dictionary(details.selectedText.toString());
                  showMenu(
                      color: Colors.white,
                      context: context,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      position: RelativeRect.fromLTRB(
                        details.globalSelectedRegion!.left,
                        details.globalSelectedRegion!.top + 40,
                        0,
                        0,
                      ),
                      items: [
                        PopupMenuItem(
                          child: SizedBox(
                            width: 250,
                            height: 40,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                IconButton(
                                    onPressed: () {
                                      List<Annotation> annotations =
                                          controller.getAnnotations();
                                      Annotation firstAnnotation =
                                          annotations.first;

                                      setState(() {
                                        controller
                                            .removeAnnotation(firstAnnotation);
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.undo,
                                      color: Colors.red,
                                    )),
                                ListView.separated(
                                    scrollDirection: Axis.horizontal,
                                    shrinkWrap: true,
                                    itemBuilder: (context, index) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            debugPrint("index$index");
                                            color_index = index;
                                            controller
                                                .annotationSettings
                                                .highlight
                                                .color = highlight_color[index];
                                            debugPrint(
                                                "color_inde$color_index");
                                            final List<PdfTextLine>? textLines =
                                                pdfview.currentState
                                                    ?.getSelectedTextLines();

                                            controller.addAnnotation(
                                                HighlightAnnotation(
                                                    textBoundsCollection:
                                                        textLines!));
                                          });
                                        },
                                        child: Icon(Icons.circle,
                                            color: highlight_color[index],
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
                      ]);
                },
                    canShowTextSelectionMenu: false,
                    'https://cdn.syncfusion.com/content/PDFViewer/flutter-succinctly.pdf'))
          ],
        ));
  }
}
