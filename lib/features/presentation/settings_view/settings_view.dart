import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_text_widget.dart';
import 'package:chat_gpt/features/presentation/settings_view/widgets/get_premium_button_widget.dart';
import 'package:chat_gpt/features/presentation/settings_view/widgets/settings_pages_buttons_widget.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late PremiumLocalDataSource _premiumLocalDataSource;
  bool isPremium = false;

  @override
  void initState() {
    super.initState();
    _premiumLocalDataSource = PremiumLocalDataSource();
    _premiumLocalDataSource.get().then((premium) {
      setState(() {
        isPremium = premium!.isPremium!;
      });
    });
  }

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
          title: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(right: 50.0),
              child: CustomTextWidget(
                text: TextConstants.instance.settings,
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
          child: Padding(
            padding: const EdgeInsets.all(18),
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
      ),
    );
  }
}
