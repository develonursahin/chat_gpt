import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/presentation/common/common_views.dart';
import 'package:flutter/material.dart';

class CustomBottomTextWidget extends StatelessWidget {
  const CustomBottomTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: buildClickableText(
              TextConstants.instance.privacyPolicy, context, () {
            _openPrivacyPolicyPage(context);
          }),
        ),
        buildVerticalDivider(),
        Flexible(
          child: buildClickableText(
              TextConstants.instance.restorePurchase, context, () {
            _openRestorePurchasePage(context);
          }),
        ),
        buildVerticalDivider(),
        Flexible(
          child: buildClickableText(TextConstants.instance.termsOfUse, context,
              () {
            _openTermsOfUsePage(context);
          }),
        ),
      ],
    );
  }

  Widget buildClickableText(
      String text, BuildContext context, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        text,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.grey,
        ),
      ),
    );
  }

  Widget buildVerticalDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 20,
      width: 1,
      color: Colors.grey,
    );
  }

  void _openPrivacyPolicyPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DynamicPage(
          title: TextConstants.instance.privacyPolicy,
          url: TextConstants.instance.privacyPolicyPageUrl,
        ),
      ),
    );
  }

  void _openRestorePurchasePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DynamicPage(
          title: TextConstants.instance.restorePurchase,
          url: TextConstants.instance.restorePurchasePageUrl,
        ),
      ),
    );
  }

  void _openTermsOfUsePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DynamicPage(
          title: TextConstants.instance.termsOfUse,
          url: TextConstants.instance.termsOfUsePageUrl,
        ),
      ),
    );
  }
}
