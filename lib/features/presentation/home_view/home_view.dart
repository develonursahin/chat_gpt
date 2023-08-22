import 'package:chat_gpt/features/core/constants/apis/openai_api.dart';
import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/data/services/chat_repository.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_logo_widget.dart';
import 'package:chat_gpt/features/presentation/home_view/home_view_model.dart';
import 'package:chat_gpt/features/presentation/home_view/widgets/custom_message_bar_widget.dart';
import 'package:chat_gpt/features/presentation/home_view/widgets/message_buble_widget.dart';
import 'package:chat_gpt/features/presentation/purchase_view/purcahse_view_model.dart';
import 'package:chat_gpt/features/presentation/purchase_view/purchase_view.dart';
import 'package:chat_gpt/features/presentation/settings_view/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:lottie/lottie.dart';
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
  late HomeViewModel homeViewModel;
  late PurchaseViewModel purchaseViewModel;
  bool isLoading = false;

  String robotResponse = '';
  int robotMessageCount = 0;
  int apiRequestCount = 0;
  bool hasText = false;
  bool messageView = false;
  bool isRequesting = false;
  bool isLimitFull = false;
  int indexNow = 0;

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
    _scrollDown();
  }

  void _scrollDown() {
    if (_scrollController.positions.isNotEmpty) {
      _scrollController.animateTo(
        _scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
  }

  Future<void> _clearChat(bool isPremium) async {
    if (isPremium) {
      showAlertDialog(context);
      await homeViewModel.clearChat();
      setState(() {});
    } else {
      CustomNavigator.goToScreen(
          context,
          const PurchaseView(
            openedFromOnboarding: true,
          ));
    }
  }

  Future<void> showAlertDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return FutureBuilder<bool>(
          future: _delayed(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/loading.json',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            } else {
              return AlertDialog(
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Lottie.asset(
                      'assets/animations/completed.json',
                      width: 150,
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ],
                ),
              );
            }
          },
        );
      },
    );

    await Future.delayed(const Duration(milliseconds: 450));

    // ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pop();
  }

  Future<bool> _delayed() async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
  }

  Future<void> _sendMessage(String message) async {
    setState(() {
      isLoading = true;
    });
    if (message.isNotEmpty && !isRequesting) {
      try {
        const apiKey = apiSecretKey;
        apiRequestCount++;
        homeViewModel.messageCount++;

        homeViewModel.updateMessageLimit(isLimitFull);
        setState(() {
          isRequesting = true;
        });
        homeViewModel.addUserMessage(message);
        _messageController.clear();
        robotResponse = await generateText(message, apiKey);
        if (kDebugMode) {
          print('API requests: $apiRequestCount');
          print('Generated Text: $robotResponse');
        }

        homeViewModel.chatProvider.addMessage(robotResponse, 'robot');
        robotMessageCount++;

        setState(() {
          isRequesting = false;
        });

        _scrollDown();
        await homeViewModel.getMessageLimit();
      } catch (e) {
        setState(() {
          isRequesting = false;
        });
        if (kDebugMode) {
          print('API request failed: $e');
        }
      }
    }
    setState(() {
      isLoading = false;
    });
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
            onPressed: () {
              _clearChat(watch.isPremium);
            },
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
                  reverse: true,
                  controller: _scrollController,
                  itemCount: watch.messages.length,
                  itemBuilder: (context, index) {
                    final message = watch.messages[index].message;
                    final sender = watch.messages[index].sender;
                    if (watch.isPremium) {
                      homeViewModel.updateMessageLimit(false);

                      watch.isLimitFull = false;
                    }
                    if (sender == "robot") {
                      if (!watch.isPremium) {
                        if (watch.messageCount >= 6 && index >= 6) {
                          // messageView = true;
                          homeViewModel.updateMessageLimit(true);
                        } else {
                          // messageView = false;
                          homeViewModel.updateMessageLimit(false);
                        }
                      } else {
                        messageView = false;
                        homeViewModel.updateMessageLimit(false);
                      }
                      messageView = false;
                    }
                    // indexNow++;
                    // // Check if this is the last message
                    // final bool isLastMessage =
                    //     index == watch.messages.length - 1;

                    // // Set isLoading to true only for the last robot message
                    // final bool isLoadingForLastRobotMessage =
                    //     sender == "robot" && isLastMessage && isLoading;
                    return MessageBubbleWidget(
                      isLoading: sender == "robot" ? isLoading : false,
                      messageView: sender == "robot" &&
                              !watch.isPremium &&
                              index == watch.messages.length - 12
                          ? true
                          : false,
                      sender: sender!,
                      message: message!,
                      alignment: sender == 'user'
                          ? CrossAxisAlignment.end
                          : CrossAxisAlignment.start,
                    );
                  },
                ),
              ),
              Consumer<HomeViewModel>(
                builder: (context, homeViewModel, child) {
                  return CustomMessageBarWidget(
                    isLimitFull: watch.isLimitFull,
                    messageController: _messageController,
                    hasText: hasText,
                    onSendPressed: _sendMessage,
                    end: () {
                      _scrollDown();
                    },
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
