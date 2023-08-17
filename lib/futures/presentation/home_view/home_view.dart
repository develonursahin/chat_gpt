import 'package:chat_gpt/futures/core/constants/apis/openai_api.dart';
import 'package:chat_gpt/futures/data/datasource/message_limit_local_datasource.dart';
import 'package:chat_gpt/futures/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/futures/data/services/chat_repository.dart';
import 'package:chat_gpt/futures/presentation/common/widgets/custom_logo_widget.dart';
import 'package:chat_gpt/futures/presentation/home_view/home_view_model.dart';
import 'package:chat_gpt/futures/presentation/home_view/widgets/custom_message_bar_widget.dart';
import 'package:chat_gpt/futures/presentation/home_view/widgets/message_buble_widget.dart';
import 'package:chat_gpt/futures/presentation/settings_view/settings_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:chat_gpt/futures/core/constants/colors/color_constants.dart';
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
  late HomeViewModel homeViewModel;

  late MessageLimitLocalDataSource _messageLimitLocalDataSource;

  String robotResponse = '';
  int robotMessageCount = 0;
  int apiRequestCount = 0;
  bool isPremium = false;
  bool hasText = false;
  bool messageView = false;
  bool isRequesting = false;
  bool isLimitFull = false;

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
    _premiumLocalDataSource = PremiumLocalDataSource();
    _premiumLocalDataSource.get().then((premium) {
      setState(() {
        isPremium = premium!.isPremium!;
      });
    });
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

  Future<void> _clearChat() async {
    await homeViewModel.clearChat();
    setState(() {});
  }

  Future<void> _sendMessage(String message) async {
    if (message.isNotEmpty && !isRequesting) {
      try {
        const apiKey = apiSecretKey;
        apiRequestCount++;
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
                  reverse: true,
                  controller: _scrollController,
                  itemCount: watch.messages.length,
                  itemBuilder: (context, index) {
                    final message = watch.messages[index].message;
                    final sender = watch.messages[index].sender;

                    if (!isPremium && !watch.isLimitFull) {
                      messageView = true;
                    } else {
                      messageView = false;
                    }

                    return MessageBubbleWidget(
                      limitedMessage: messageView,
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
                end: () {
                  _scrollDown();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
