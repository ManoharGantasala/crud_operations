import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:crud_operations/app/modules/home/models/person.dart';

class PersonService {
  //References || Important
  static CollectionReference<Person> get collectionReference =>
      FirebaseFirestore.instance.collection('Persons').withConverter(
            fromFirestore: (snapshot, options) =>
                Person.fromMap(snapshot.data()!),
            toFirestore: (value, options) => value.toMap(),
          );

  static Future<bool> checkInternet() async {
    final connectionResult = await Connectivity().checkConnectivity();
    return connectionResult != ConnectivityResult.none;
  }

  //CRUD Methods

  //Cost - 1 Read, 1 Write
  static Future add(Person person) async {
    final internetAvailable =
        await checkInternet(); //TODO: Check internet connectivity.

    if (internetAvailable) {
      final exists = (await collectionReference.doc(person.id).get()).exists;
      if (exists) {
        throw "The person is already present in the database!!";
      } else {
        await collectionReference.doc(person.id).set(person.copyWith(
              updationDate: DateTime.now(),
            ));
      }
    } else {
      throw "Please check your internet connection!!";
    }
  }

  //Cost - 1 Read, 1 Write
  static Future edit(Person person) async {
    final internetAvailable =
        await checkInternet(); //TODO: Check internet connectivity.

    if (internetAvailable) {
      final exists = (await collectionReference.doc(person.id).get()).exists;
      if (exists) {
        await collectionReference.doc(person.id).set(person.copyWith(
              updationDate: DateTime.now(),
            ));
      } else {
        throw "This person don't exists in the database!!";
      }
    } else {
      throw "Please check your internet connection!!";
    }
  }

  //Cost - 1 Write
  static Future set(Person person) async {
    final internetAvailable =
        await checkInternet(); //TODO: Check internet connectivity.

    if (internetAvailable) {
      await collectionReference.doc(person.id).set(person.copyWith(
            updationDate: DateTime.now(),
          ));
    } else {
      throw "Please check your internet connection!!";
    }
  }

  //Cost - 1 Delete
  static Future delete(Person person) async {
    await deleteById(person.id);
  }

  //Cost - 1 Delete
  static Future deleteById(String personId) async {
    final internetAvailable =
        await checkInternet(); //TODO: Check internet connectivity.

    if (internetAvailable) {
      await collectionReference.doc(personId).delete();
    } else {
      throw "Please check your internet connection!!";
    }
  }

  //Cost - 1 Read
  static Future<Person?> get(String personId) async {
    final internetAvailable =
        await checkInternet(); //TODO: Check internet connectivity.

    if (internetAvailable) {
      final documentSnapshot = await collectionReference.doc(personId).get();
      return documentSnapshot.data();
    } else {
      throw "Please check your internet connection!!";
    }
  }

  //Cost - Undefined Reads
  static Future<List<Person>> getAll() async {
    final internetAvailable =
        await checkInternet(); //TODO: Check internet connectivity.

    if (internetAvailable) {
      final querySnapshot =
          (await collectionReference.orderBy('name', descending: false).get())
              .docs;
      return querySnapshot.map((doc) => doc.data()).toList();
    } else {
      throw "Please check your internet connection!!";
    }
  }

  //Helper methods and getters

  static String get newId => collectionReference.doc().id;
}
