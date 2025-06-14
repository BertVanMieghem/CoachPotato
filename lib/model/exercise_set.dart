class ExerciseSet {
  factory ExerciseSet.fromMap(Map<String, dynamic> data) => ExerciseSet(
    reps: data['reps'] as int,
    weight: (data['weight'] as num).toDouble(),
    rpe: (data['rpe'] as num?)?.toDouble(),
    note: data['note'] as String?,
  );

  ExerciseSet({
    required this.reps,
    required this.weight,
    this.rpe,
    this.note,
  });

  final int reps;
  final double weight;
  final double? rpe;
  final String? note;


  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reps': reps,
      'weight': weight,
      'rpe': rpe,
      'note': note,
    };
  }

  ExerciseSet copy() {
    return ExerciseSet(
      reps: reps,
      weight: weight,
      rpe: rpe,
      note: note,
    );
  }
}