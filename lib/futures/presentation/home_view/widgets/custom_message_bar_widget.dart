import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:flutter/material.dart';

class CustomMessageBarWidget extends StatelessWidget {
  const CustomMessageBarWidget({
    Key? key,
    required TextEditingController messageController,
    required this.hasText,
    required this.onSendPressed,
    required this.end,
  })  : _messageController = messageController,
        super(key: key);

  final TextEditingController _messageController;
  final bool hasText;
  final Function(String) onSendPressed;
  final VoidCallback end;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
        border:
            Border(top: BorderSide(color: ColorConstant.instance.darkGreen)),
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
                  hintText: 'Say something...',
                  hintStyle: TextStyle(color: ColorConstant.instance.darkGrey),
                ),
                style: TextStyle(
                  color: hasText
                      ? ColorConstant.instance.white
                      : ColorConstant.instance.darkGreen,
                ),
                maxLines: null, // Allow multiple lines
                textInputAction: TextInputAction.newline,
              ),
            ),
          ),
          IconButton(
            onPressed: () async {
              await onSendPressed(_messageController.text);
              end;
            },
            icon: const Icon(Icons.send, size: 30),
            color: hasText
                ? ColorConstant.instance.green
                : ColorConstant.instance.darkGrey,
          ),
        ],
      ),
    );
  }
}
