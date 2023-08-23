import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/presentation/purchase_view/purchase_view.dart';
import 'package:flutter/material.dart';

class CustomMessageBarWidget extends StatelessWidget {
  const CustomMessageBarWidget({
    Key? key,
    required TextEditingController messageController,
    required this.hasText,
    required this.onSendPressed,
    required this.end,
    required this.isLimitFull,
  })  : _messageController = messageController,
        super(key: key);

  final TextEditingController _messageController;
  final bool hasText;
  final Function(String) onSendPressed;
  final VoidCallback end;
  final bool isLimitFull;

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _getPremiumforMoreChat() async {
      CustomNavigator.goToScreen(
          context,
          const PurchaseView(
            openedFromOnboarding: true,
          ));
    }

    return Container(
      height: 65,
      decoration: BoxDecoration(
        border: Border(
            top: BorderSide(
                color: ColorConstant.instance.darkGreen, width: 2.5)),
        color: ColorConstant.instance.black,
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: TextConstants.instance.saySomething,
                  hintStyle: TextStyle(color: ColorConstant.instance.darkGrey),
                ),
                style: TextStyle(
                  color: hasText
                      ? ColorConstant.instance.white
                      : ColorConstant.instance.darkGreen,
                ),
                maxLines: null,
                textInputAction: TextInputAction.newline,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              if (isLimitFull) {
                FocusScope.of(context).unfocus();
                await Future.delayed(const Duration(milliseconds: 220));
                await _getPremiumforMoreChat();
              } else {
                await onSendPressed(_messageController.text);
              }
              end;
              _messageController.clear();
            },
            icon: const Icon(Icons.send, size: 30),
            color: hasText
                ? ColorConstant.instance.green
                : ColorConstant.instance.darkGrey,
          )
        ],
      ),
    );
  }
}
