import 'package:crud_operations/app/modules/persons/controllers/add_edit_person_controller.dart';
import 'package:crud_operations/app/modules/persons/controllers/persons_controller.dart';
import 'package:get/get.dart';

class PersonsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddEditPersonController>(
      () => AddEditPersonController(),
    );
    Get.lazyPut<PersonsController>(
      () => PersonsController(),
    );
  }
}
