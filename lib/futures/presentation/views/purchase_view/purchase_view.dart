import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/futures/core/routes/custom_navigator.dart';
import 'package:chat_gpt/futures/presentation/views/common/widgets/custom_text_widget.dart';
import 'package:chat_gpt/futures/presentation/views/home_view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PurchaseView extends StatelessWidget {
  const PurchaseView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.instance.black,
      appBar: AppBar(
        backgroundColor: ColorConstant.instance.black,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 34),
            child: IconButton(
              onPressed: () =>
                  CustomNavigator.goToScreen(context, const HomeView()),
              icon: const Icon(Icons.close_rounded),
              color: ColorConstant.instance.darkGrey,
            ),
          )
        ],
      ),
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SvgPicture.asset("assets/icons/logo.svg"),
          const CustomTextWidget(
            text: "Unlimited chat with gpt for only, Try It Now.",
            fontSize: 20,
          ),
          Row(children: [
            Icon(Icons.lock, color: ColorConstant.instance.green),
            const CustomTextWidget(
              text: "Unlock to continue",
            )
          ]),
        ],
      )),
    );
  }
}
