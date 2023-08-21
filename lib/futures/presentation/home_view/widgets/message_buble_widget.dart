import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/futures/core/routes/custom_navigator.dart';
import 'package:chat_gpt/futures/presentation/purchase_view/purchase_view.dart';
import 'package:chat_gpt/futures/presentation/common/widgets/custom_text_widget.dart';

class MessageBubbleWidget extends StatefulWidget {
  final String message;
  final CrossAxisAlignment alignment;
  final String sender;
  final bool messageView;
  final bool isLoading;

  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.alignment,
    required this.sender,
    required this.messageView,
    required this.isLoading,
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
            title: const CustomTextWidget(
              text: "Copied!",
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
      'assets/animations/3dots.json',
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
                child: Image.asset('assets/icons/lock.png'),
              ),
              const CustomTextWidget(
                text: "Top to Unlock",
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
    return Column(
      crossAxisAlignment: widget.alignment,
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 3 / 5,
          child: Row(
            children: [
              if (widget.alignment == CrossAxisAlignment.start)
                Padding(
                  padding: const EdgeInsets.only(top: 80),
                  child: CircleAvatar(
                    maxRadius: 10,
                    minRadius: 10,
                    backgroundColor: Colors.transparent,
                    child: Image.asset(
                      "assets/icons/robot.png",
                    ),
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
                            if (widget.isLoading)
                              threeDotLoadingAnimation()
                            else
                              Expanded(
                                child: widget.messageView
                                    ? lockMessage()
                                    : unlockMessage(),
                              ),
                            if (widget.alignment == CrossAxisAlignment.start &&
                                !widget.isLoading)
                              IconButton(
                                onPressed: () {
                                  Clipboard.setData(ClipboardData(
                                      text: widget.message.substring(0, 10)));
                                  _showCopiedMessagePopup(
                                      'Message copied:\n${widget.message.substring(0, 10)}');
                                },
                                icon: Icon(
                                  Icons.content_copy_rounded,
                                  size: 20,
                                  color: ColorConstant.instance.grey,
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
