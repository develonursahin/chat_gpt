import 'package:chat_gpt/features/core/constants/apis/openai_api.dart';
import 'package:chat_gpt/features/core/hive/hive_box.dart';
import 'package:chat_gpt/features/core/routes/custom_navigator.dart';
import 'package:chat_gpt/features/data/datasource/message_limit_local_datasource.dart';
import 'package:chat_gpt/features/data/datasource/premium_local_data_source.dart';
import 'package:chat_gpt/features/data/models/message_limit_model.dart';
import 'package:chat_gpt/features/data/services/chat_repository.dart';
import 'package:chat_gpt/features/presentation/home_view/chat_view_model.dart';
import 'package:chat_gpt/features/presentation/purchase_view/purchase_view.dart';
import 'package:flutter/foundation.dart';
import 'package:chat_gpt/features/data/models/chat_model.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeViewModel with ChangeNotifier {
  final ChatProvider chatProvider = ChatProvider();
  final MessageLimitLocalDataSource _messageLimitLocalDataSource =
      MessageLimitLocalDataSource();
  final PremiumLocalDataSource _premiumLocalDataSource =
      PremiumLocalDataSource();
  final TextEditingController messageController = TextEditingController();
  final ScrollController scrollController =
      ScrollController(keepScrollOffset: true);

  bool isPremium = false;
  bool isLimitFull = false;
  bool isLoading = false;
  bool isRequesting = false;
  String robotResponse = '';
  String firstMessage = "Hi, how can i help you?";
  bool hasText = false;
  String sender = 'robot';
  int apiRequestCount = 0;
  int messageCount = 0;
  int robotMessageCount = 0;

  List<ChatModel> get messages => chatProvider.messages;
  Future<void> initialize() async {
    messageController.addListener(updateState);
    await chatProvider.initialize();
    await getMessageLimit();
    await getPremium();
    scrollDown();
    notifyListeners();
  }

  void updateState() {
    hasText = messageController.text.isNotEmpty;
    notifyListeners();
  }

  void scrollDown() {
    if (scrollController.positions.isNotEmpty) {
      scrollController.animateTo(
        scrollController.position.minScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      );
    }
    notifyListeners();
  }

  Future<void> clearChat(BuildContext context) async {
    if (isPremium) {
      showAlertDialog(context);
      chatProvider.clearChatProvider();
      chatProvider.addMessage(firstMessage, sender);
      notifyListeners();
    } else {
      CustomNavigator.goToScreen(
        context,
        const PurchaseView(openedFromOnboarding: true),
      );
    }
    notifyListeners();
  }

  Future<bool> _delayed() async {
    await Future.delayed(const Duration(seconds: 3));
    return true;
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
    notifyListeners();
  }

  Future<void> sendMessage(String message) async {
    isLoading = true;
    if (message.isNotEmpty && !isRequesting) {
      try {
        const apiKey = apiSecretKey;
        apiRequestCount++;
        messageCount++;
        updateMessageLimit(isLimitFull);
        isRequesting = true;
        addUserMessage(message);
        messageController.clear();
        robotResponse = await generateText(message, apiKey);
        await Future.delayed(const Duration(milliseconds: 450));
        chatProvider.addMessage(robotResponse, 'robot');
        robotMessageCount++;
        isRequesting = false;
        scrollDown();
        await getMessageLimit();
      } catch (e) {
        isRequesting = false;
        if (kDebugMode) {
          print('API request failed: $e');
        }
      }
    }
    isLoading = false;
    notifyListeners();
  }

  Future<void> getPremium() async {
    if (getPremiumBox.isNotEmpty) {
      var getPremiumModel = await _premiumLocalDataSource.get();
      isPremium = getPremiumModel!.isPremium!;
    }
    notifyListeners();
  }

  Future<void> getMessageLimit() async {
    if (messageLimitBox.isNotEmpty) {
      var messageLimitModel = await _messageLimitLocalDataSource.get();
      isLimitFull = messageLimitModel!.isLimitFull!;
      messageCount = messageLimitModel.messageCount!;
    }
    notifyListeners();
  }

  Future<void> updateMessageLimit(bool isLimitFull) async {
    if (messageLimitBox.isNotEmpty) {
      await _messageLimitLocalDataSource.update(MessageLimitModel(
          isLimitFull: isLimitFull, messageCount: messageCount));
    }
    notifyListeners();
  }

  Future<void> clearViewModelChat() async {
    chatProvider.clearChatProvider();
    messages.clear();
    notifyListeners();
  }

  Future<void> addUserMessage(String message) async {
    await chatProvider.addMessage(message, 'user');
    notifyListeners();
  }
}
