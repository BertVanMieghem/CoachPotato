import 'package:faker/faker.dart';

class Faker {
  static Map<String, dynamic> getFakeTrainee() {
    return <String, dynamic>{
      'coach_id': '2QPYiJHMked0aw3p1vA97rmeHJ22',
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