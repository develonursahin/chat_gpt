import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/futures/presentation/common/common_views.dart';
import 'package:chat_gpt/futures/presentation/common/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class SettingPagesButtonsWidget extends StatelessWidget {
  SettingPagesButtonsWidget({
    Key? key,
  }) : super(key: key);

  final List<Map<String, dynamic>> settingsItems = [
    {
      'imagePath': 'assets/icons/rate_us.png',
      'title': 'Rate Us',
      'content': 'Rate Us Page Content',
    },
    {
      'imagePath': 'assets/icons/contact_us.png',
      'title': 'Contact Us',
      'content': 'Contact Us Page Content',
    },
    {
      'imagePath': 'assets/icons/privacy_policy.png',
      'title': 'Privacy Policy',
      'content': 'Privacy Policy Page Content',
    },
    {
      'imagePath': 'assets/icons/terms_of_use.png',
      'title': 'Terms of Use',
      'content': 'Terms of Use Page Content',
    },
    {
      'imagePath': 'assets/icons/restore_purchase.png',
      'title': 'Restore Purchase',
      'content': 'Restore Purchase Page Content',
    },
  ];

  void _openSettingsPage(BuildContext context, String title, String content) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DynamicPage(
          title: title,
          content: content,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(23),
        border: Border.all(color: ColorConstant.instance.darkGreen),
      ),
      child: Column(
        children: [
          for (var item in settingsItems)
            InkWell(
              onTap: () {
                _openSettingsPage(context, item['title'], item['content']);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      color: ColorConstant.instance.darkGreen,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: CircleAvatar(
                          backgroundColor: ColorConstant.instance.transparent,
                          child: Image.asset(item['imagePath']),
                        ),
                      ),
                      Expanded(
                        flex: 95,
                        child: CustomTextWidget(
                          text: item['title'],
                          fontWeight: FontWeight.w500,
                          fontSize: 19,
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 24,
                        color: ColorConstant.instance.darkGrey,
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
