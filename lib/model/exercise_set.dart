class ExerciseSet {
  factory ExerciseSet.fromMap(Map<String, dynamic> data) => ExerciseSet(
    id: data['id'] as String,
    weight: data['weight'] as double?,
    reps: data['reps'] as int,
    rpe: data['rpe'] as int?,
    note: data['note'] as String?,
    orderIndex: data['order_index'] as int,
    createdAt: data['created_at'] as int,
  );

  ExerciseSet({
    required this.reps,
    required this.createdAt,
    required this.orderIndex,
    this.weight,
    this.rpe,
    this.id,
    this.note,
    this.updatedAt,
  });


  String? id;
  double? weight;
  int reps;
  int? rpe;
  String? note;
  int orderIndex;
  int createdAt;
  int? updatedAt;

  @override
  String toString() {
    return 'ExerciseSet{id: $id, weight: $weight, reps: $reps, rpe: $rpe, note: $note, orderIndex: $orderIndex, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'weight': weight,
      'reps': reps,
      'rpe': rpe,
      'note': note,
      'order_index': orderIndex,
      'created_on': createdAt,
      'updated_on': updatedAt,
    };
  }
}