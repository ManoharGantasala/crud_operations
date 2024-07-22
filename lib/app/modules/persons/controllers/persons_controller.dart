import 'package:crud_operations/app/modules/home/models/person.dart';
import 'package:crud_operations/app/modules/home/services/person_service.dart';
import 'package:crud_operations/app/routes/app_pages.dart';
import 'package:get/get.dart';

class PersonsController extends GetxController {
  final loading = true.obs;
  final error = Rx<String?>(null);
  final persons = <Person>[].obs;

  void onFABPressed() => Get.toNamed(Routes.ADDEDITPERSON)?.then(
        (value) {
          if (value != null) {
            getData();
          }
        },
      );

  void onPersonItemPressed(Person person) => Get.toNamed(
        Routes.ADDEDITPERSON,
        arguments: person,
      )?.then(
        (value) {
          if (value != null) {
            getData();
          }
        },
      );
  void getData() async {
    error.value = null;
    loading.value = true;
    try {
      final result = await PersonService.getAll();
      persons.clear();
      persons.addAll(result);
      loading.value = false;
    } catch (e) {
      error.value = e.toString();
      loading.value = false;
    }
  }

  @override
  void onInit() {
    getData();
    super.onInit();
  }
}
