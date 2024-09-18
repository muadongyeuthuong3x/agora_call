import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/colors.dart';
import 'package:my_project/common/utils/utils.dart';
import 'package:my_project/common/widgets/custom_button.dart';
import 'package:my_project/futures/auth/controller/auth_controller.dart';
import 'package:my_project/futures/auth/screens/user_information_screen.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  static const routeName = '/login-screen';
  @override
  ConsumerState<LoginScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends ConsumerState<LoginScreen> {
  final phoneController = TextEditingController();
  Country? country;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    phoneController.dispose();
  }

  void pickCountry() {
    showCountryPicker(
        context: context,
        onSelect: (Country _country) {
          setState(() {
            country = _country;
          });
        });
  }

  void sendPhoneNumber() {
    String phoneNumber = phoneController.text.trim();
     print('CCCCCCC: $phoneNumber');
    if (country != null && phoneNumber.isNotEmpty) {
      ref
          .read(authControllerProvider)
          .signInWithPhone(context, '+${country!.phoneCode}$phoneNumber');
      // Navigator.pushAndRemoveUntil(
      //   context,
      //   MaterialPageRoute(builder: (context) => UserInformationScreen()),
      //   (Route<dynamic> route) => false,
      // );
      print("CCCCCCC");
    } else {
      showSnackBar(context: context, content: 'Fill out all the fields');
    }
  }

  @override
  Widget build(BuildContext context) {
    // use do chiều dài chiều rộng màn hình
    final sizeScreen = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Your phone number"),
        elevation: 0.4,
        backgroundColor: backgroundColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text("whatApp will need to verify your phone number."),
            const SizedBox(height: 10),
            TextButton(
                onPressed: () => pickCountry(),
                child: const Text('Pick Country')),
            const SizedBox(height: 5),
            Row(
              children: [
                if (country != null) Text('+${country?.phoneCode}'),
                const SizedBox(
                  width: 10,
                ),
                SizedBox(
                  width: sizeScreen.width * 0.7,
                  child: TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(hintText: 'phone number'),
                  ),
                )
              ],
            ),
            const Spacer(),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 50.0),
              child:
                  CustomButton(textButton: "Next", onPressed: sendPhoneNumber),
            ),
          ],
        ),
      ),
    );
  }
}
