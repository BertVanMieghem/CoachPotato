class Training {
  factory Training.fromMap(Map<String, dynamic> data) => Training(
    id: data['id'] as String,
    name: data['name'] as String,
    description: data['description'] as String?,
    createdAt: data['created_at'] as int,
    updatedAt: data['updated_at'] as int?,
  );

  Training({
    required this.name,
    required this.createdAt,
    this.id,
    this.description,
    this.updatedAt,
  });


  String? id;
  String name;
  String? description;
  int createdAt;
  int? updatedAt;

  @override
  String toString() {
    return 'Training{id: $id, name: $name, description: $description, createdAt: $createdAt, updatedAt: $updatedAt}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'created_on': createdAt,
      'updated_on': updatedAt,
    };
  }
}