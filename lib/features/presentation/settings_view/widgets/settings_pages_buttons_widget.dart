import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/presentation/common/common_views.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class SettingPagesButtonsWidget extends StatelessWidget {
  SettingPagesButtonsWidget({
    Key? key,
  }) : super(key: key);

  final List<Map<String, dynamic>> settingsItems = [
    {
      TextConstants.instance.imagePath: TextConstants.instance.rateusPath,
      TextConstants.instance.title: TextConstants.instance.rateUs,
      TextConstants.instance.content: TextConstants.instance.rateUsPageUrl,
    },
    {
      TextConstants.instance.imagePath: TextConstants.instance.contactUsPath,
      TextConstants.instance.title: TextConstants.instance.contactUs,
      TextConstants.instance.content: TextConstants.instance.contactUsPageUrl,
    },
    {
      TextConstants.instance.imagePath:
          TextConstants.instance.privacyPolicyPath,
      TextConstants.instance.title: TextConstants.instance.privacyPolicy,
      TextConstants.instance.content:
          TextConstants.instance.privacyPolicyPageUrl,
    },
    {
      TextConstants.instance.imagePath: TextConstants.instance.termsOfUsePath,
      TextConstants.instance.title: TextConstants.instance.termsOfUse,
      TextConstants.instance.content: TextConstants.instance.termsOfUsePageUrl,
    },
    {
      TextConstants.instance.imagePath:
          TextConstants.instance.restorePurchasePath,
      TextConstants.instance.title: TextConstants.instance.restorePurchase,
      TextConstants.instance.content:
          TextConstants.instance.restorePurchasePageUrl,
    },
  ];

  void _openSettingsPage(BuildContext context, String title, String url) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DynamicPage(
          title: title,
          url: url,
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
                _openSettingsPage(context, item[TextConstants.instance.title],
                    item[TextConstants.instance.content]);
              },
              child: Container(
                decoration: BoxDecoration(
                  border: BorderDirectional(
                    bottom: BorderSide(
                      // ignore: unrelated_type_equality_checks
                      color: item != settingsItems.last
                          ? ColorConstant.instance.darkGreen
                          : ColorConstant.instance.transparent,
                    ),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 20,
                        child: CircleAvatar(
                          backgroundColor: ColorConstant.instance.transparent,
                          child: Image.asset(
                              item[TextConstants.instance.imagePath]),
                        ),
                      ),
                      Expanded(
                        flex: 95,
                        child: CustomTextWidget(
                          text: item[TextConstants.instance.title],
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
