import 'package:coach_potato/model/exercise_set.dart';

class Exercise {
  factory Exercise.fromMap(Map<String, dynamic> data) => Exercise(
    id: data['id'] as String,
    name: data['name'] as String,
    sets: data['sets'] as List<ExerciseSet>?,
    note: data['note'] as String?,
    orderIndex: data['order_index'] as int,
    createdAt: data['created_at'] as int,
    updatedAt: data['updated_at'] as int?,
  );

  Exercise({
    required this.name,
    required this.createdAt,
    required this.orderIndex,
    this.id,
    this.sets,
    this.note,
    this.updatedAt,
  });


  String? id;
  String name;
  List<ExerciseSet>? sets;
  String? note;
  int orderIndex;
  int createdAt;
  int? updatedAt;

  @override
  String toString() {
    return 'Exercise{id: $id, name: $name, sets: $sets, note: $note, orderIndex: $orderIndex, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'sets': sets,
      'note': note,
      'order_index': orderIndex,
      'created_on': createdAt,
      'updated_on': updatedAt,
    };
  }
}