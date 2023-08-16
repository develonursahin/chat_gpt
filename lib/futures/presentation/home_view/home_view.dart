import 'package:chat_gpt/futures/core/constants/apis/openai_api.dart';
import 'package:chat_gpt/futures/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/futures/data/services/chat_repository.dart';
import 'package:chat_gpt/futures/presentation/common/widgets/custom_logo_widget.dart';
import 'package:chat_gpt/futures/presentation/common/widgets/custom_text_widget.dart';
import 'package:chat_gpt/futures/presentation/home_view/home_view_model.dart';
import 'package:chat_gpt/futures/presentation/settings_view/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController =
      ScrollController(keepScrollOffset: true);
  late PremiumLocalDataSource _premiumLocalDataSource;
  bool isPremium = false;
  int robotMessageCount = 0;
  late HomeViewModel homeViewModel;
  String robotResponse = '';
  bool hasText = false;
  int apiRequestCount = 0; // API istek sayacı
  bool isRequesting = false;

  @override
  void initState() {
    super.initState();
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    _messageController.addListener(() {
      setState(() {
        hasText = _messageController.text.isNotEmpty;
      });
    });
    homeViewModel.initialize();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
      } else if (_scrollController.position.pixels == 0) {
        _scrollController.jumpTo(0); // Yukarı kaydırma işlemi
      }
    });
    _premiumLocalDataSource = PremiumLocalDataSource();
    _premiumLocalDataSource.get().then((premium) {
      setState(() {
        isPremium = premium!.isPremium!;
      });
    });
  }

  Future<void> _clearChat() async {
    await homeViewModel.clearChat();
    setState(() {
      // Reset any necessary variables or state here
    });
  }

  void _sendMessage(String message) async {
    if (message.isNotEmpty && !isRequesting) {
      try {
        const apiKey = apiSecretKey;
        apiRequestCount++;
        setState(() {
          isRequesting = true;
        });

        robotResponse = await generateText(message, apiKey);

        if (kDebugMode) {
          print('API requests: $apiRequestCount');
          print('Generated Text: $robotResponse');
        }
        homeViewModel.addUserMessage(message);

        homeViewModel.chatProvider.addMessage(robotResponse, 'robot');
        _messageController.clear();
        robotMessageCount++;

        if (isPremium && robotMessageCount == 6) {
          setState(() {
            robotMessageCount = 0;
          });
        }
        setState(() {
          isRequesting = false;
        });

        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      } catch (e) {
        setState(() {
          isRequesting = false;
        });
        if (kDebugMode) {
          print('API request failed: $e');
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var watch = context.watch<HomeViewModel>();
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
            onPressed: _clearChat,
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
                  CupertinoPageRoute(
                    builder: (context) => const SettingsView(),
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
                  controller: _scrollController,
                  itemCount: watch.messages.length,
                  itemBuilder: (context, index) {
                    final message = watch.messages[index].message;
                    final sender = watch.messages[index].sender;

                    return MessageBubbleWidget(
                      messages: watch.messages,
                      isPremium: isPremium,
                      robotMessageCount: robotMessageCount,
                      sender: sender!,
                      message: message!,
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
  final String sender;
  final bool isPremium;
  final int robotMessageCount;
  final List messages;

  const MessageBubbleWidget({
    Key? key,
    required this.message,
    required this.alignment,
    required this.sender,
    required this.isPremium,
    required this.robotMessageCount,
    required this.messages,
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

    int robotMessageCountCheck() {
      int newRobotMessageCount = widget.robotMessageCount;

      for (int i = 0; i < widget.messages.length; i++) {
        if (widget.messages[i].sender == "robot") {
          newRobotMessageCount++;
        }
      }
      return newRobotMessageCount;
    }

    int robotMessageIndexCheck() {
      int robotMessageIndex = 0;
      List<int> robotMessages = [];

      for (int i = 0; i < widget.messages.length; i++) {
        if (widget.messages[i].sender == "robot") {
          robotMessages[i] = i;
          for (int j = 0; j < robotMessages.length; j++) {
            if (j >= 6) {
              robotMessageIndex = robotMessages[6];
            }
          }
        }
      }
      return robotMessageIndex;
    }

    Widget robotMessageController() {
      return Column(
        children: [
          const SizedBox(height: 10),
          Text(
            widget.message.substring(0, 10),
            style: const TextStyle(color: Colors.white),
          ),
          TextButton(
            onPressed: () {},
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
                              child:
                                  // widget.sender == 'robot' &&
                                  //         !widget.isPremium &&
                                  //         robotMessageCountCheck() >= 6 &&
                                  //         robotMessageIndexCheck() >= 6
                                  //     ? robotMessageController() :
                                  Text(
                                widget.message,
                                style: TextStyle(
                                  color: ColorConstant.instance.white,
                                ),
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
