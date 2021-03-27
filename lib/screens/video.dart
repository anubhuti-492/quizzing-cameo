import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../shared/shared.dart';
import '../services/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'dart:io';

import 'package:webview_flutter/webview_flutter.dart';

class VideoScreen extends StatefulWidget {
  @override
  VideoScreenState createState() => VideoScreenState();
}

class VideoScreenState extends State<VideoScreen> {
  @override
  void initState() {
    super.initState();
    // Enable hybrid composition.
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: 'https://flutter.dev',
    );
  }
}
// class VideoScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       // appBar: AppBar(
//       //   title: const Text('Flutter WebView example'),
//       // ),
//       child: const WebView(
//         initialUrl: 'https://flutter.io',
//         javascriptMode: JavascriptMode.unrestricted,
//       ),
//     );
//   }
// }

// _launchURL(String url) async {
//   print(url);
//   if (await canLaunch(url)) {
//     await launch(url);
//   } else {
//     throw 'Could not launch $url';
//   }
// }
