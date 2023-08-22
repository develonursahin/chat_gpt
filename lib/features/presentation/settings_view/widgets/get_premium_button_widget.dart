import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_text_widget.dart';
import 'package:chat_gpt/features/presentation/purchase_view/purchase_view.dart';
import 'package:flutter/material.dart';

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
