

import 'package:flutter/material.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:my_project/futures/select_contacts/repository/select_contact_repository.dart';

final getContactsProvider = FutureProvider((ref){
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return selectContactRepository.getContracts();
});


final selectContactControllerProvider = Provider((ref){
  final selectContactRepository = ref.watch(selectContactsRepositoryProvider);
  return SelectContractController(ref: ref, selectContactRepository: selectContactRepository);
});

class SelectContractController {
  final ProviderRef ref;
  final SelectContactRepository selectContactRepository;

  SelectContractController({
    required this.ref,
    required this.selectContactRepository
  });

  void selectContact(Contact selectContact, BuildContext context) async{
     selectContactRepository.selectContact(selectContact, context);

  }
}