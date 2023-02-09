import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:new_app/widgets/error_message.dart';
import 'package:new_app/widgets/utils.dart';
import 'package:new_app/widgets/vertical_spacing.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:webview_flutter/webview_flutter.dart';

class NewsDetailsWebView extends StatefulWidget {
  const NewsDetailsWebView({Key? key, required this.url}) : super(key: key);
  final String url;

  @override
  State<NewsDetailsWebView> createState() => _NewsDetailsWebViewState();
}

class _NewsDetailsWebViewState extends State<NewsDetailsWebView> {
  late WebViewController _webViewController;
  double _progress = 0.0;

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).getColor;
    return WillPopScope(
      //can go back when we click link
      onWillPop: () async {
        if (await _webViewController.canGoBack()) {
          _webViewController.goBack();
          // stay inside
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(IconlyLight.arrowLeft2),
            ),
            iconTheme: IconThemeData(color: color),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            centerTitle: true,
            title: Text(
              widget.url,
              style: TextStyle(color: color),
            ),
            actions: [
              IconButton(
                onPressed: () async {
                  await _showModalSheetFct();
                },
                icon: const Icon(
                  Icons.more_horiz,
                ),
              ),
            ]),
        body: Column(
          children: [
            LinearProgressIndicator(
              value: _progress,
              color: _progress == 1.0 ? Colors.transparent : Colors.blue,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            ),
            Expanded(
              child: WebView(
                initialUrl: widget.url,
                zoomEnabled: true,
                onProgress: (progress) {
                  setState(() {
                    _progress = progress / 100;
                  });
                },
                onWebViewCreated: (controller) {
                  _webViewController = controller;
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _showModalSheetFct() async {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(20),
          ),
        ),
        context: context,
        builder: (context) {
          return Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min, //editor size
              children: [
                VerticalSpacing(20),
                Center(
                  child: Container(
                    height: 5,
                    width: 35,
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                VerticalSpacing(20),
                Text(
                  'More option',
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 20,
                  ),
                ),
                VerticalSpacing(20),
                Divider(
                  thickness: 2,
                ),
                VerticalSpacing(20),
                ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                  onTap: () async {
                    try {
                      await Share.share(widget.url,
                          subject: 'Look what I made!');
                    } catch (e) {
                      ErrorMessage.errorDialog(context, e.toString());
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.open_in_browser),
                  title: Text('Open in brower'),
                  onTap: () async {
                    if (!await launchUrl(Uri.parse(widget.url))) {
                      throw 'Could not launch ${widget.url}';
                    }
                  },
                ),
                ListTile(
                  leading: Icon(Icons.refresh),
                  title: Text('Refresh'),
                  onTap: () async {
                    try {
                      await _webViewController.reload();
                    } catch (e) {
                      log('erroe occurred $e');
                    } finally {
                      Navigator.pop(context);
                    }
                  },
                )
              ],
            ),
          );
        });
  }
}
