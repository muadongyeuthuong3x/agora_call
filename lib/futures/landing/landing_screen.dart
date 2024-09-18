import 'package:flutter/material.dart';
import 'package:my_project/common/widgets/custom_button.dart';
import 'package:my_project/futures/auth/screens/login_screen.dart';

// stf

class LandingScreen extends StatelessWidget {
  const LandingScreen({super.key});

  void navigateToLoginScreen(BuildContext context){
    Navigator.pushNamed(context, LoginScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    // use do chiều dài chiều rộng màn hình
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 50),
          const Center(
            child: Text(
              "App call video",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 33,
              ),
            ),
          ),
          SizedBox(height: sizeScreen.height / 50),
          Image.asset(
            "assets/images/kma.jpg",
            height: 340,
            width: 340,
          ),
          SizedBox(height: sizeScreen.height / 50),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                'Welcome app KMA code by Nguyễn Mạnh Cường',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height:  10,),
          const Spacer(), 
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0 , vertical: 50.0),
            child: CustomButton(textButton: "Register", onPressed: () => navigateToLoginScreen(context)),
          ),
        ],
      )),
    );
  }
}
