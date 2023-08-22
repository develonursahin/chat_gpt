import 'package:chat_gpt/futures/presentation/common/common_views.dart';
import 'package:flutter/material.dart';

class CustomBottomTextWidget extends StatelessWidget {
  const CustomBottomTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: buildClickableText("Privacy Policy", context, () {
            _openPrivacyPolicyPage(context);
          }),
        ),
        buildVerticalDivider(),
        Flexible(
          child: buildClickableText("Restore Purchase", context, () {
            _openRestorePurchasePage(context);
          }),
        ),
        buildVerticalDivider(),
        Flexible(
          child: buildClickableText("Terms of Use", context, () {
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
        builder: (context) => const DynamicPage(
          title: 'Privacy Policy',
          content: 'Privacy Policy Page Content',
        ),
      ),
    );
  }

  void _openRestorePurchasePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DynamicPage(
          title: 'Restore Purchase',
          content: 'Restore Purchase Page Content',
        ),
      ),
    );
  }

  void _openTermsOfUsePage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const DynamicPage(
          title: 'Terms of Use',
          content: 'Terms Of Use Page Content',
        ),
      ),
    );
  }
}
