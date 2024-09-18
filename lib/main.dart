import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/colors.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:my_project/common/widgets/error.dart';
import 'package:my_project/common/widgets/loader.dart';
import 'package:my_project/firebase_options.dart';
import 'package:my_project/futures/auth/controller/auth_controller.dart';
import 'package:my_project/futures/auth/screens/user_information_screen.dart';
import 'package:my_project/futures/landing/landing_screen.dart';
import 'package:my_project/mobile_layout_screen.dart';
import 'package:my_project/router.dart';
void main() async {
  // SETUP KHOI TAO TRUOC KHI RUN PROJECT
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Whatsapp UI```````````````',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
        appBarTheme: const AppBarTheme(
          color: appBarColor
        )
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: ref.watch(userDataAuthProvider).when(data: (user) {
        if(user == null) {
          return const LandingScreen();
        }
        return const MobileLayoutScreen();
      }, error: (err, trace){
        return ErrorScreen(error: err.toString());
      }, loading: ()=> const Loader())
    );
  }
}
