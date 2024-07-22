import 'package:crud_operations/app/modules/home/models/person.dart';
import 'package:crud_operations/app/modules/home/services/person_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditPersonController extends GetxController {
  final person = Person.create().obs;

  final isEditing = false.obs;
  final loading = false.obs;
  final nameError = Rx<String?>(null);
  final emailError = Rx<String?>(null);
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  void onDeleteButtonPressed() async {
    loading.value = true;
    try {
      // await PersonService.delete(person.value);
      await PersonService.deleteById(person.value.id);
      Get.back(result: true);
    } catch (e) {
      //TODO:Show snackbar
    }
    loading.value = false;
  }

  void onSaveButtonPressed() async {
    if (isInputValid()) {
      person.value = person.value.copyWith(
        name: nameController.text.trim(),
        email: emailController.text.trim(),
      );

      try {
        await PersonService.set(person.value);
        Get.back(result: true);
      } catch (e) {
        //TODO: Show snackbar with error
      }
    }
  }

  bool isInputValid() {
    nameError.value = null;
    emailError.value = null;
    if (nameController.text.trim().isEmpty) {
      nameError.value = "Please enter person name here!!";
    }

    if (emailController.text.trim().isEmpty) {
      emailError.value = "Please enter person email here!!";
    }

    return nameError.value == null && emailError.value == null;
  }

  @override
  void onInit() {
    if (Get.arguments != null) {
      try {
        person.value = Get.arguments;
        isEditing.value = true;
      } catch (e) {}
    }
    nameController.text = person.value.name;
    emailController.text = person.value.email;
    super.onInit();
  }
}
