import 'package:crud_operations/app/modules/persons/controllers/add_edit_person_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddEditPersonView extends GetView<AddEditPersonController> {
  const AddEditPersonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(
          () => Text(
            controller.isEditing.value ? 'Edit Person' : 'Add Person',
          ),
        ),
        actions: [
          Obx(
            () => controller.isEditing.value
                ? IconButton(
                    icon: const Icon(Icons.delete),
                    color: Theme.of(context).colorScheme.error,
                    onPressed: controller.loading.value
                        ? null
                        : controller.onDeleteButtonPressed,
                  )
                : const LimitedBox(),
          )
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            final loading = controller.loading.value;

            return Column(
              children: [
                if (loading) const LinearProgressIndicator(),
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: TextField(
                              enabled: !loading,
                              keyboardType: TextInputType.name,
                              controller: controller.nameController,
                              textInputAction: TextInputAction.next,
                              textCapitalization: TextCapitalization.words,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Name",
                                errorText: controller.nameError.value,
                                suffixIcon: const Icon(Icons.person),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(12),
                            child: TextField(
                              enabled: !loading,
                              textInputAction: TextInputAction.done,
                              controller: controller.emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                filled: true,
                                labelText: "Email",
                                errorText: controller.emailError.value,
                                suffixIcon: const Icon(Icons.email),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(24),
                            child: FilledButton(
                              onPressed: controller.onSaveButtonPressed,
                              child: const Text("Save"),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
