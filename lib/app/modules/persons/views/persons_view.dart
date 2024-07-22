import 'package:crud_operations/app/modules/persons/controllers/persons_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PersonsView extends GetView<PersonsController> {
  const PersonsView({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Persons"),
        actions: [
          IconButton(
            onPressed: controller.getData,
            icon: const Icon(Icons.refresh),
          ),
          const SizedBox(width: 8),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.onFABPressed,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: Obx(
          () {
            final error = controller.error.value;
            final loading = controller.loading.value;
            final persons = controller.persons;

            if (error != null) {
              return Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        error,
                        textAlign: TextAlign.center,
                        style: textTheme.titleLarge!.copyWith(
                          color: colorScheme.onSurface,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(32),
                      child: FilledButton(
                        style: ButtonStyle(
                          backgroundColor: WidgetStatePropertyAll(
                            colorScheme.error,
                          ),
                          foregroundColor: WidgetStatePropertyAll(
                            colorScheme.onError,
                          ),
                          overlayColor: WidgetStatePropertyAll(
                            colorScheme.onError.withOpacity(0.1),
                          ),
                        ),
                        onPressed: controller.getData,
                        child: const Text("Refresh"),
                      ),
                    ),
                  ],
                ),
              );
            }

            if (loading) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const LinearProgressIndicator(),
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "Getting persons, please wait...",
                          textAlign: TextAlign.center,
                          style: textTheme.titleLarge!.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            if (persons.isEmpty) {
              return Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(
                          "No persons added yet!!",
                          textAlign: TextAlign.center,
                          style: textTheme.titleLarge!.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              itemCount: persons.length,
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 80),
              itemBuilder: (context, index) {
                final person = persons[index];

                return Card.outlined(
                  margin: const EdgeInsets.all(8),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: ListTile(
                    onTap: () => controller.onPersonItemPressed(person),
                    title: Text(person.name),
                    subtitle: Text(person.email),
                    contentPadding: const EdgeInsets.all(16),
                    leading: CircleAvatar(
                      radius: 28,
                      backgroundColor: colorScheme.primary,
                      foregroundColor: colorScheme.onPrimary,
                      child: Text(
                        person.name[0].toUpperCase(),
                        style: textTheme.titleLarge!.copyWith(
                          color: colorScheme.onPrimary,
                        ),
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
