import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class DynamicPage extends StatelessWidget {
  final String title;
  final String content;

  const DynamicPage({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

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
              text: title,
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
      body: Center(
        child: CustomTextWidget(
          text: content,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dynamic Pages Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  final List<Map<String, String>> pages = [
    {'title': 'Rate Us', 'content': 'Rate Us Page Content'},
    {'title': 'Contact Us', 'content': 'Contact Us Page Content'},
    {'title': 'Privacy Policy', 'content': 'Privacy Policy Page Content'},
    {'title': 'Terms Of Use', 'content': 'Terms Of Use Page Content'},
    {'title': 'Restore Purchase', 'content': 'Restore Purchase Page Content'},
  ];

  MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dynamic Pages Example'),
      ),
      body: ListView.builder(
        itemCount: pages.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(pages[index]['title']!),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => DynamicPage(
                    title: pages[index]['title']!,
                    content: pages[index]['content']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
