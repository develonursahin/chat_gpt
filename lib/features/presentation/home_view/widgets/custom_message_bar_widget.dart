import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/presentation/purchase_view/purchase_view.dart';
import 'package:flutter/material.dart';

class CustomMessageBarWidget extends StatefulWidget {
  const CustomMessageBarWidget({
    Key? key,
    required TextEditingController messageController,
    required this.hasText,
    required this.onSendPressed,
    required this.end,
    required this.isLimitFull,
    required this.isRotated,
  })  : _messageController = messageController,
        super(key: key);

  final TextEditingController _messageController;
  final bool hasText;
  final Function(String) onSendPressed;
  final VoidCallback end;
  final bool isLimitFull;
  final bool isRotated;

  @override
  State<CustomMessageBarWidget> createState() => _CustomMessageBarWidgetState();
}

class _CustomMessageBarWidgetState extends State<CustomMessageBarWidget> {
  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    double height;
    if (widget.isRotated) {
      height = MediaQuery.sizeOf(context).height * 0.3;
    } else {
      height = MediaQuery.sizeOf(context).height * 0.07;
    }
    // ignore: no_leading_underscores_for_local_identifiers
    Future<void> _getPremiumforMoreChat() async {
      CustomNavigator.goToScreen(
          context,
          const PurchaseView(
            openedFromOnboarding: true,
          ));
    }

    return Container(
      height: height,
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
                controller: widget._messageController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: TextConstants.instance.saySomething,
                  hintStyle: TextStyle(color: ColorConstant.instance.darkGrey),
                ),
                style: TextStyle(
                  color: widget.hasText
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
              if (widget.isLimitFull) {
                FocusScope.of(context).unfocus();
                await Future.delayed(const Duration(milliseconds: 220));
                await _getPremiumforMoreChat();
              } else {
                await widget.onSendPressed(widget._messageController.text);
              }
              widget.end;
              widget._messageController.clear();
            },
            icon: const Icon(Icons.send, size: 30),
            color: widget.hasText
                ? ColorConstant.instance.green
                : ColorConstant.instance.darkGrey,
          )
        ],
      ),
    );
  }
}
