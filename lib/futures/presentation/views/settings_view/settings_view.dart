import 'package:chat_gpt/futures/presentation/views/common/common_views.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/futures/presentation/views/common/widgets/custom_text_widget.dart';
import 'package:chat_gpt/futures/presentation/views/purchase_view/purchase_view.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({Key? key}) : super(key: key);
  final bool isPremium = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                text: 'Settings',
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Visibility(
                visible: !isPremium,
                child: const GetPremiumCardWidget(),
              ),
              const SizedBox(height: 20),
              SettingPagesButtonsWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class SettingPagesButtonsWidget extends StatelessWidget {
  SettingPagesButtonsWidget({
    super.key,
  });
  final List<Map<String, dynamic>> settingsItems = [
    {
      'imagePath': 'assets/icons/rate_us.png',
      'title': 'Rate Us',
    },
    {
      'imagePath': 'assets/icons/contact_us.png',
      'title': 'Contact Us',
    },
    {
      'imagePath': 'assets/icons/privacy_policy.png',
      'title': 'Privacy Policy',
    },
    {
      'imagePath': 'assets/icons/terms_of_use.png',
      'title': 'Terms of Use',
    },
    {
      'imagePath': 'assets/icons/restore_purchase.png',
      'title': 'Restore Purchase',
    },
  ];

  void _openSettingsPage(BuildContext context, String title) {
    // Navigate to the respective page based on the title
    if (title == 'Rate Us') {
      // Navigate to the 'Rate Us' page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RateUsPage(),
        ),
      );
    } else if (title == 'Contact Us') {
      // Navigate to the 'Contact Us' page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const ContactUsPage(),
        ),
      );
    } else if (title == 'Privacy Policy') {
      // Navigate to the 'Privacy Policy' page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PrivacyPolicyPage(),
        ),
      );
    } else if (title == 'Terms of Use') {
      // Navigate to the 'Terms of Use' page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const TermsOfUsePage(),
        ),
      );
    } else if (title == 'Restore Purchase') {
      // Navigate to the 'Restore Purchase' page
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const RestorePurchasePage(),
        ),
      );
    }
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
                _openSettingsPage(context, item['title']);
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

class GetPremiumCardWidget extends StatelessWidget {
  const GetPremiumCardWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 86,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  const PurchaseView(openedFromOnboarding: false),
            ),
          );
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
          color: ColorConstant.instance.darkGreen,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Expanded(
                    flex: 30, child: Image.asset("assets/icons/diamond.png")),
                const Expanded(
                  flex: 95,
                  child: CustomTextWidget(
                      text: "Get Premium!",
                      fontWeight: FontWeight.w600,
                      fontSize: 20),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: ColorConstant.instance.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
