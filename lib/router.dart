import 'package:flutter/material.dart';
import 'package:my_project/common/widgets/error.dart';
import 'package:my_project/futures/auth/screens/login_screen.dart';
import 'package:my_project/futures/auth/screens/otp_screen.dart';
import 'package:my_project/futures/auth/screens/user_information_screen.dart';
import 'package:my_project/futures/select_contacts/screens/select_contacts_screen.dart';
import 'package:my_project/futures/chat/screeens/mobile_chat_screen.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case UserInformationScreen.routeName:
      return MaterialPageRoute(builder: (context) => UserInformationScreen());
    case LoginScreen.routeName:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case OtpScreen.routeName:
      final verificationId = settings.arguments as String;
      return MaterialPageRoute(
          builder: (context) => OtpScreen(
                verificationId: verificationId,
              ));
    case SelectContactsScreen.routeName:
      return MaterialPageRoute(
          builder: (context) => const SelectContactsScreen());
    case MobileChatScreen.routeName:
       final arguments = settings.arguments as Map<String , dynamic>;
       final name = arguments['name'];
       final uid = arguments['uid'];
      return MaterialPageRoute(
          builder: (context) => MobileChatScreen(
            name: name,
            uid : uid,
          ));
    default:
      return MaterialPageRoute(
          builder: (context) => const Scaffold(
                body: ErrorScreen(error: 'This page does exist'),
              ));
  }
}
