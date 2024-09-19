import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/common/utils/utils.dart';
import 'package:my_project/futures/models/user_model.dart';
import 'package:my_project/futures/chat/screeens/mobile_chat_screen.dart';

final selectContactsRepositoryProvider = Provider(
    (ref) => SelectContactRepository(firestore: FirebaseFirestore.instance));

class SelectContactRepository {
  final FirebaseFirestore firestore;

  SelectContactRepository({
    required this.firestore,
  });

  Future<List<Contact>> getContracts() async {
    List<Contact> contacts = [];
    try {
      if (await FlutterContacts.requestPermission()) {
        contacts = await FlutterContacts.getContacts(withProperties: true);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return contacts;
  }

  void selectContact(Contact selectContact, BuildContext context) async {
    try {
      if (await FlutterContacts.requestPermission()) {
        var userCollection = await firestore.collection('users').get();
        bool isFound = false;
        for (var document in userCollection.docs) {
          var userData = UserModel.fromMap(document.data());
          String selectdPhoneNum =
              selectContact.phones[0].number.replaceAll('', '');
          if (selectdPhoneNum == userData.phoneNumber) {
            isFound = true;
            Navigator.pushNamed(context, MobileChatScreen.routeName , arguments: {
              'name': userData.name,
              'uid': userData.uid
            });
          }
        }
        if (!isFound) {
          showSnackBar(
              context: context,
              content: 'This number does not exits on this app.');
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
