import 'package:crud_operations/app/modules/home/services/person_service.dart';

class Person {
  final String id;
  final String name;
  final String email;
  final DateTime creationDate;
  final DateTime updationDate;

  factory Person.create() {
    return Person(
      name: "",
      email: "",
      id: PersonService.newId,
      creationDate: DateTime.now(),
      updationDate: DateTime.now(),
    );
  }

  const Person({
    required this.id,
    required this.name,
    required this.email,
    required this.creationDate,
    required this.updationDate,
  });

  Person copyWith({
    String? id,
    String? name,
    String? email,
    DateTime? creationDate,
    DateTime? updationDate,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      creationDate: creationDate ?? this.creationDate,
      updationDate: updationDate ?? this.updationDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'creationDate': creationDate.microsecondsSinceEpoch,
      'updationDate': updationDate.microsecondsSinceEpoch,
    };
  }

  factory Person.fromMap(Map<String, dynamic> map) {
    return Person(
      id: map['id'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      creationDate: DateTime.fromMicrosecondsSinceEpoch(
        map['creationDate'] as int,
      ),
      updationDate: DateTime.fromMicrosecondsSinceEpoch(
        map['updationDate'] as int,
      ),
    );
  }
}
