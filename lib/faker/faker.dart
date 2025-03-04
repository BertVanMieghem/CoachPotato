import 'package:faker/faker.dart';

class Faker {
  static Map<String, dynamic> getFakeTrainee() {
    return <String, dynamic>{
      'first_name': faker.person.firstName(),
      'last_name': faker.person.lastName(),
      'email': faker.internet.email(),
      'phone': faker.phoneNumber.us(),
      'discipline': faker.lorem.word(),
      'created_at': DateTime.now().millisecondsSinceEpoch,
      'updated_at': null,
    };
  }
}