import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/presentation/purchase_view/purchase_view.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_text_widget.dart';

class MessageBubbleWidget extends StatefulWidget {
  final String message;
  final CrossAxisAlignment alignment;
  final String sender;
  final bool messageView;

  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.alignment,
    required this.sender,
    required this.messageView,
  }) : super(key: key);

  @override
  State<MessageBubbleWidget> createState() => _MessageBubbleWidgetState();
}

class _MessageBubbleWidgetState extends State<MessageBubbleWidget> {
  bool disposed = false;
  bool showLoading = true;
  double characterLength = 2.5;

  @override
  void initState() {
    super.initState();
    _startLoadingAnimation();
  }

  @override
  void dispose() {
    disposed = true;
    super.dispose();
  }

  void _startLoadingAnimation() async {
    await Future.delayed(const Duration(milliseconds: 1500));
    if (!disposed) {
      setState(() {
        showLoading = false;
      });
    }
  }

  void _showCopiedMessagePopup(String copiedMessage) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return SizedBox(
          height: 150,
          width: 150,
          child: AlertDialog(
            backgroundColor: Colors.black.withOpacity(0.8),
            title: CustomTextWidget(
              text: TextConstants.instance.copied,
              textAlign: TextAlign.center,
            ),
          ),
        );
      },
    );
  }

  Widget unlockMessage() {
    return CustomTextWidget(
      text: widget.message,
      fontWeight: FontWeight.w500,
      fontSize: 14,
    );
  }

  Widget threeDotLoadingAnimation() {
    return Lottie.asset(
      TextConstants.instance.threeDotsJsonPath,
      width: 30,
      fit: BoxFit.cover,
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
              const PurchaseView(openedFromOnboarding: true),
            );
          },
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: ColorConstant.instance.transparent,
                child: Image.asset(TextConstants.instance.lockImagePath),
              ),
              CustomTextWidget(
                text: TextConstants.instance.topToUnlock,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            ],
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    int length = widget.message.length;

    return Column(
      crossAxisAlignment: widget.alignment,
      children: [
        SizedBox(
          width: length < 20 ? null : MediaQuery.of(context).size.width * 3 / 5,
          child: IntrinsicWidth(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                if (widget.alignment == CrossAxisAlignment.start)
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: CircleAvatar(
                      maxRadius: 10,
                      minRadius: 10,
                      backgroundColor: Colors.transparent,
                      child: Image.asset(TextConstants.instance.robotImagePath),
                    ),
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
                              if (widget.message ==
                                  TextConstants.instance.emptyMessage)
                                threeDotLoadingAnimation()
                              else
                                Expanded(
                                  child: widget.messageView
                                      ? lockMessage()
                                      : unlockMessage(),
                                ),
                              if (widget.alignment == CrossAxisAlignment.start)
                                widget.message !=
                                        TextConstants.instance.emptyMessage
                                    ? IconButton(
                                        onPressed: () {
                                          widget.messageView
                                              ? Clipboard.setData(ClipboardData(
                                                  text: widget.message
                                                      .substring(0, 10)))
                                              : Clipboard.setData(ClipboardData(
                                                  text: widget.message));
                                          widget.messageView
                                              ? _showCopiedMessagePopup(widget
                                                  .message
                                                  .substring(0, 10))
                                              : _showCopiedMessagePopup(
                                                  widget.message);
                                        },
                                        icon: Icon(
                                          Icons.content_copy_rounded,
                                          size: 20,
                                          color: ColorConstant.instance.grey,
                                        ),
                                      )
                                    : const SizedBox.shrink(),
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
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
