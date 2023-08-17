import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/futures/core/routes/custom_navigator.dart';
import 'package:chat_gpt/futures/presentation/common/widgets/custom_text_widget.dart';
import 'package:chat_gpt/futures/presentation/purchase_view/purchase_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MessageBubbleWidget extends StatefulWidget {
  final String message;
  final CrossAxisAlignment alignment;
  final String sender;
  final bool limitedMessage;

  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.alignment,
    required this.sender,
    required this.limitedMessage,
  }) : super(key: key);

  @override
  State<MessageBubbleWidget> createState() => _MessageBubbleWidgetState();
}

class _MessageBubbleWidgetState extends State<MessageBubbleWidget> {
  bool disposed = false;
  bool showLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          showLoading = false;
        });
      }
    });
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    void _showCopiedMessagePopup(String copiedMessage) {
      showDialog(
        context: context,
        builder: (BuildContext dialogContext) {
          return SizedBox(
            height: 150,
            width: 150,
            child: AlertDialog(
                backgroundColor: Colors.black.withOpacity(0.8),
                title: const CustomTextWidget(
                  text: "Copied!",
                  textAlign: TextAlign.center,
                )),
          );
        },
      );
    }

    Widget unlockMessage() {
      return Text(
        widget.message,
        style: TextStyle(
          color: ColorConstant.instance.white,
        ),
      );
    }

    Widget lockMessage() {
      return Column(
        children: [
          const SizedBox(height: 10),
          Text(
            widget.message.substring(0, 10),
            style: const TextStyle(color: Colors.white),
          ),
          TextButton(
            onPressed: () {
              CustomNavigator.goToScreen(
                  context,
                  const PurchaseView(
                    openedFromOnboarding: true,
                  ));
            },
            child: const Text(
              "Top to Unlock",
              style: TextStyle(color: Colors.white),
            ),
          )
        ],
      );
    }

    return Column(
      crossAxisAlignment: widget.alignment,
      children: [
        SizedBox(
          width: 250,
          child: Row(
            children: [
              if (widget.alignment == CrossAxisAlignment.start)
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 40, right: 5),
                      child: CircleAvatar(
                        maxRadius: 10,
                        minRadius: 10,
                        backgroundColor: Colors.transparent,
                        child: Image.asset(
                          "assets/icons/robot.png",
                        ),
                      ),
                    ),
                  ],
                ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(16),
                      topRight: widget.alignment == CrossAxisAlignment.end
                          ? const Radius.circular(0)
                          : const Radius.circular(16),
                      bottomRight: const Radius.circular(16),
                      bottomLeft: widget.alignment == CrossAxisAlignment.start
                          ? const Radius.circular(0)
                          : const Radius.circular(16),
                    ),
                    color: widget.alignment == CrossAxisAlignment.end
                        ? ColorConstant.instance.green
                        : ColorConstant.instance.textFormFieldColor,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: widget.limitedMessage == true
                                  ? lockMessage()
                                  : unlockMessage(),
                            ),
                            if (widget.alignment == CrossAxisAlignment.start)
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(
                                      ClipboardData(text: widget.message));
                                  _showCopiedMessagePopup(
                                      'Message copied:\n${widget.message}');
                                },
                                icon: const Icon(
                                  Icons.copy_rounded,
                                  size: 20,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
