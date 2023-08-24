import 'package:chat_gpt/features/core/constants/texts/text_constants.dart';
import 'package:chat_gpt/features/presentation/common/widgets/custom_logo_widget.dart';
import 'package:chat_gpt/features/presentation/home_view/home_view_model.dart';
import 'package:chat_gpt/features/presentation/home_view/widgets/custom_message_bar_widget.dart';
import 'package:chat_gpt/features/presentation/home_view/widgets/message_buble_widget.dart';
import 'package:chat_gpt/features/presentation/settings_view/settings_view.dart';
import 'package:chat_gpt/features/core/constants/colors/color_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late HomeViewModel homeViewModel;
  bool isLoading = false;
  bool messageView = false;
  bool isRotated = false;

  @override
  void initState() {
    super.initState();
    homeViewModel = Provider.of<HomeViewModel>(context, listen: false);
    homeViewModel.initialize();
  }

  @override
  Widget build(BuildContext context) {
    var watch = context.watch<HomeViewModel>();
    final Orientation orientation = MediaQuery.of(context).orientation;
    isRotated = orientation == Orientation.landscape;

    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.instance.black,
        appBar: isRotated
            ? null // Hide the AppBar when isRotated is true
            : AppBar(
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
                  onPressed: () async {
                    FocusScope.of(context).unfocus();
                    await Future.delayed(const Duration(milliseconds: 220));
                    // ignore: use_build_context_synchronously
                    watch.clearChat(context);
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
                  controller: watch.scrollController,
                  itemCount: watch.messages.length,
                  itemBuilder: (context, index) {
                    final message = watch.messages[index].message;
                    final sender = watch.messages[index].sender;

                    if (watch.isPremium) {
                      watch.updateMessageLimit(false);

                      watch.isLimitFull = false;
                    }
                    if (sender == TextConstants.instance.robot) {
                      if (!watch.isPremium) {
                        if (watch.messageCount >= 6 && index >= 6) {
                          watch.updateMessageLimit(true);
                        } else {
                          watch.updateMessageLimit(false);
                        }
                      } else {
                        messageView = false;
                        watch.updateMessageLimit(false);
                      }
                      messageView = false;
                    }

                    return Consumer<HomeViewModel>(
                        builder: (context, homeViewModel, child) {
                      return MessageBubbleWidget(
                        messageView: sender == TextConstants.instance.robot &&
                                !watch.isPremium &&
                                index == watch.messages.length - 13
                            ? true
                            : false,
                        sender: sender!,
                        message: message!,
                        alignment: sender == TextConstants.instance.user
                            ? CrossAxisAlignment.end
                            : CrossAxisAlignment.start,
                      );
                    });
                  },
                ),
              ),
              Consumer<HomeViewModel>(
                builder: (context, homeViewModel, child) {
                  return CustomMessageBarWidget(
                    isRotated: isRotated,
                    isLimitFull: watch.isLimitFull,
                    messageController: watch.messageController,
                    hasText: watch.hasText,
                    onSendPressed: watch.sendMessage,
                    end: () {
                      watch.scrollDown();
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
