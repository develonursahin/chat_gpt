import 'package:chat_gpt/futures/presentation/views/common/widgets/custom_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:chat_gpt/futures/presentation/views/common/widgets/custom_logo_widget.dart';
import 'package:chat_gpt/futures/presentation/views/settings_view/settings_view.dart';
import 'package:flutter/services.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _messageController = TextEditingController();
  bool hasText = false;
  List<Map<String, dynamic>> chatMessages = [];
  int robotMessageCount = 0;

  @override
  void initState() {
    super.initState();
    _messageController.addListener(() {
      setState(() {
        hasText = _messageController.text.isNotEmpty;
      });
    });
  }

  void _sendMessage(String message) {
    if (message.isNotEmpty) {
      setState(() {
        chatMessages.add({
          'message': message,
          'sender': 'user', // 'user' or 'robot'
        });
      });
      // Simulate robot response
      Future.delayed(const Duration(milliseconds: 300), () {
        setState(() {
          chatMessages.add({
            'message': 'Robot response to: $message',
            'sender': 'robot',
          });
          robotMessageCount++;
        });
      });
      _messageController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Mesaj girilmedi'),
      ));
    }
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
          title: const Center(child: CustomLogoWidget()),
          leading: IconButton(
            icon: Icon(
              Icons.cached_rounded,
              color: ColorConstant.instance.white,
              size: 24,
            ),
            onPressed: () {},
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.settings_rounded,
                color: ColorConstant.instance.white,
                size: 24,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>  const SettingsView(),
                  ),
                );
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = chatMessages[index]['message'];
                    final sender = chatMessages[index]['sender'];

                    return MessageBubbleWidget(
                      message: message,
                      alignment: sender == 'user'
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                    );
                  },
                ),
              ),
              CustomMessageBarWidget(
                messageController: _messageController,
                hasText: hasText,
                onSendPressed: _sendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MessageBubbleWidget extends StatefulWidget {
  final String message;
  final CrossAxisAlignment alignment;

  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.alignment,
  }) : super(key: key);

  @override
  State<MessageBubbleWidget> createState() => _MessageBubbleWidgetState();
}

class _MessageBubbleWidgetState extends State<MessageBubbleWidget> {
  bool showLoading = true;
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        showLoading = false;
      });
    });
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            widget.message,
                            style:
                                TextStyle(color: ColorConstant.instance.white),
                          ),
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

class CustomMessageBarWidget extends StatelessWidget {
  const CustomMessageBarWidget({
    Key? key,
    required TextEditingController messageController,
    required this.hasText,
    required this.onSendPressed,
  })  : _messageController = messageController,
        super(key: key);

  final TextEditingController _messageController;
  final bool hasText;
  final Function(String) onSendPressed;

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
            onPressed: () => onSendPressed(_messageController.text),
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
