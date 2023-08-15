import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/futures/presentation/views/common/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';

class RateUsPage extends StatelessWidget {
  const RateUsPage({super.key});

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
        title: const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: CustomTextWidget(
              text: 'Rate Us',
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
      body: const Center(
        child: CustomTextWidget(
          text: 'Rate Us Page Content',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({super.key});

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
        title: const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: CustomTextWidget(
              text: 'Contact Us',
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
      body: const Center(
        child: CustomTextWidget(
          text: 'Contact Us Page Content',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

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
        title: const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: CustomTextWidget(
              text: 'Privacy Policy',
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
      body: const Center(
        child: CustomTextWidget(
          text: 'Privacy Policy Page Content',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class TermsOfUsePage extends StatelessWidget {
  const TermsOfUsePage({super.key});

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
        title: const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: CustomTextWidget(
              text: 'Terms Of Use',
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
      body: const Center(
        child: CustomTextWidget(
          text: 'Terms Of Use Page Content',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class RestorePurchasePage extends StatelessWidget {
  const RestorePurchasePage({super.key});

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
        title: const Align(
          alignment: Alignment.center,
          child: Padding(
            padding: EdgeInsets.only(right: 50.0),
            child: CustomTextWidget(
              text: 'Restore Purchase',
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
      body: const Center(
        child: CustomTextWidget(
          text: 'Restore Purchase Page Content',
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
