import 'package:flutter/material.dart';

class CustomBottomTextWidget extends StatelessWidget {
  const CustomBottomTextWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: buildClickableText("Privacy Policy", context),
        ),
        buildVerticalDivider(),
        Flexible(
          child: buildClickableText("Restore Purchase", context),
        ),
        buildVerticalDivider(),
        Flexible(
          child: buildClickableText("Terms of Use", context),
        ),
      ],
    );
  }

  Widget buildClickableText(String text, BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        text,
        style: const TextStyle(
          decoration: TextDecoration.underline,
          color: Colors.grey, // Örnek renk
        ),
      ),
    );
  }

  Widget buildVerticalDivider() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      height: 20,
      width: 1,
      color: Colors.grey, // Örnek renk
    );
  }
}
