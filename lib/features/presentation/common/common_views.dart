import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_text_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter/material.dart';

class DynamicPage extends StatefulWidget {
  final String title;
  final String url;

  const DynamicPage({
    Key? key,
    required this.title,
    required this.url,
  }) : super(key: key);

  @override
  State<DynamicPage> createState() => _DynamicPageState();
}

class _DynamicPageState extends State<DynamicPage> {
  late WebViewController controller;
  double currentProgress = 0.0;

  void setWebView() {
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(const Color(0x00000000))
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            setState(() {
              currentProgress = progress / 100;
            });
          },
          onPageStarted: (String url) {
            setState(() {
              currentProgress = 0;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              currentProgress = 1;
            });
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            if (request.url.startsWith('https://www.youtube.com/')) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  void initState() {
    super.initState();
    setWebView();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstant.instance.black,
        appBar: AppBar(
          shape: Border(
            bottom: BorderSide(
              color: ColorConstant.instance.darkGreen,
              width: 1.5,
            ),
          ),
          backgroundColor: ColorConstant.instance.black,
          title: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: CustomTextWidget(
                text: widget.title,
                fontWeight: FontWeight.w700,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded,
                color: ColorConstant.instance.white),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: Column(
          children: [
            currentProgress != 1
                ? LinearProgressIndicator(
                    value: currentProgress,
                  )
                : const SizedBox.shrink(),
            Expanded(child: WebViewWidget(controller: controller)),
          ],
        ));
  }
}
