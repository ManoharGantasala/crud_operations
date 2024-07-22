import 'package:crud_operations/app/modules/persons/views/add_edit_person_view.dart';
import 'package:get/get.dart';

import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/persons/bindings/persons_binding.dart';
import '../modules/persons/views/persons_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.PERSONS;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.PERSONS,
      page: () => const PersonsView(),
      binding: PersonsBinding(),
    ),
    GetPage(
      name: _Paths.ADDEDITPERSON,
      page: () => const AddEditPersonView(),
      binding: PersonsBinding(),
    ),
  ];
}
