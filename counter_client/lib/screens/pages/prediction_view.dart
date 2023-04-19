import 'package:flutter/material.dart';

import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';


// ignore: prefer_collection_literals
final Set<JavascriptChannel> jsChannels = [
  JavascriptChannel(
      name: 'Print', onMessageReceived: (JavascriptMessage message) {}),
].toSet();

class PredictionPage extends StatefulWidget {
  const PredictionPage({super.key});

  @override
  State<PredictionPage> createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();

  String js =
      "document.querySelector('meta[name=\"viewport\"]').setAttribute('content', 'width=1024px, initial-scale=' + (document.documentElement.clientWidth / 1024));";

  @override
  Widget build(BuildContext context) {
    final flutterWebViewPlugin = FlutterWebviewPlugin();

    flutterWebViewPlugin.onProgressChanged.listen((event) {
      debugPrint("Progress $event");

      //this will make show in desktop mode
      flutterWebViewPlugin.evalJavascript(js);
    });

    return WebviewScaffold(
      appBar: AppBar(
        title: const Text("Prediction Mode"),
      ),
      url: 'http://10.0.2.2:5500/Project/frontend/pages/predictions.html',
      withJavascript: true,
      useWideViewPort: true,
      displayZoomControls: false,
      scrollBar: true,
      withZoom: false,
    );
  }
}
