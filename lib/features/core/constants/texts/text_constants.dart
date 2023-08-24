class TextConstants {
  static final TextConstants _instance = TextConstants._init();
  static TextConstants get instance => _instance;
  TextConstants._init();

//Asset Paths
  String loadingJsonPath = 'assets/animations/loading.json';
  String completedJsonPath = 'assets/animations/completed.json';
  String threeDotsJsonPath = 'assets/animations/3dots.json';
  String lockImagePath = 'assets/icons/lock.png';
  String robotImagePath = 'assets/icons/robot.png';
  String diamondPath = 'assets/icons/diamond.png';
  String rateusPath = 'assets/icons/rate_us.png';
  String contactUsPath = 'assets/icons/contact_us.png';
  String privacyPolicyPath = 'assets/icons/privacy_policy.png';
  String termsOfUsePath = 'assets/icons/terms_of_use.png';
  String restorePurchasePath = 'assets/icons/restore_purchase.png';
  String splashPath = 'assets/icons/splash.png';
  String logoPath = 'assets/icons/logo.svg';

//Main
  String appTitle = 'Chat GPT';

//CommonView
  //Widgets
  //Custom Logo Widget
  String chat = 'Chat';
  String gpt = 'GPT';
  String fontFamily = 'Inter';

//Home View
  //Home View Model
  String firstMessage = 'Hi, how can i help you?';
  String sender = 'robot';
  String robotResponse = '';
  String robot = 'robot';
  String user = 'user';
  String emptyMessage = '   ';
  //Chat View Model
  String chatMessages = 'chat_messages';
  //Widgets
  //Custom Message Bar Widget
  String getPremium = 'Get Premium ->';
  String saySomething = 'Say something...';
  //Message Buble Widget
  String topToUnlock = 'Top to Unlock';
  String copied = 'Copied!';

//Onboarding View
  String next = 'Next';
  //Onboarding View Model
  String text1 = 'text1';
  String text2 = 'text2';
  String text3 = 'text3';
  String imagePath = 'imagePath';

  String onBoarding1Text1 = 'Lorem';
  String onBoarding1Text2 = 'Ipsum dolor sit';
  String onBoarding1Text3 = 'Ask the bot anything, It’s always ready to help!';
  String onBoarding1imagePath = 'assets/icons/onboard1.png';

  String onBoarding2Text1 = 'Lorem';
  String onBoarding2Text2 = 'Ipsum dolor sit';
  String onBoarding2Text3 = 'Get the best answers from our application Enjoy!';
  String onBoarding2imagePath = 'assets/icons/onboard2.png';

//Settings View
  String settings = 'Settings';
  //Settings Widgets
  //Get Premium Button Widget
  String getPremiumSettings = 'Get Premium!';
  //Settings Pages Buttons Widget
  String title = 'title';
  String content = 'content';
  String rateUs = 'Rate Us';
  String rateUsPageUrl = 'https://www.neonapps.co';
  String contactUs = 'Contact Us';
  String contactUsPageUrl = 'https://www.neonapps.co/about-us';
  String privacyPolicy = 'Privacy Policy';
  String privacyPolicyPageUrl = 'https://www.neonapps.co/referance-apps';
  String termsOfUse = 'Terms of Use';
  String termsOfUsePageUrl = 'https://www.neonapps.co/sales-process';
  String restorePurchase = 'Restore Purchase';
  String restorePurchasePageUrl = 'https://www.neonapps.co/neon-academy';

//Chat Repository
  String contentType = 'Content-Type';
  String authorization = 'Authorization';
  String model = 'model';
  String prompt = 'prompt';
  String maxTokens = 'max_tokens';
  String choices = 'choices';
  String text = 'text';
  String error = 'error';
  String message = 'message';
  String apiUrl = 'https://api.openai.com/v1/completions';

//Hive Box
  String premiumModel = 'premium_model';
  String onboardingModel = 'onboarding_model';
  String messageLimitModel = 'message_limit_model';

//Splash View

//Commons View
  String commonsViewTitle = '';

//Purchase View
  String purchase = 'Purchase';
  //Widgets
  //Purchase Card Widget
  String weekly = 'Weekly';
  String weekPrice = 'US\$3.99/week';
  String monthly = 'Monthly';
  String monthPrice = 'US\$19.99/month';
  String yearly = 'Annual';
  String yearPrice = 'US\$39.99/year';
  //Unlock To Continue Widget
  String unlockToContinue = 'Unlock to continue';
  //Purchase View Model
  String name = 'name';
  String price = 'price';
  String tryItNow = 'Try It Now';
  String pleaseSelectAPaymentOption = 'Please select a payment option';
  String unlimitedChatWithGPT = 'Unlimited chat with gpt for only, Try It Now.';
}
