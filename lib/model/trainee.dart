class Trainee {
  factory Trainee.fromMap(Map<String, dynamic> data) => Trainee(
    id: data['id'] as int,
    firstName: data['first_name'] as String?,
    lastName: data['last_name'] as String,
    email: data['email'] as String,
    phone: data['phone'] as String?,
    discipline: data['discipline'] as String?,
    createdOn: data['created_at'] as int,
    updatedOn: data['updated_at'] as int?,
  );

  Trainee({
    required this.lastName,
    required this.email,
    required this.createdOn,
    this.id,
    this.firstName,
    this.phone,
    this.discipline,
    this.updatedOn,
  });


  int? id;
  String? firstName;
  String lastName;
  String email;
  String? phone;
  String? discipline;
  int createdOn;
  int? updatedOn;


  @override
  String toString() {
    return 'Trainee{id: $id, firstName: $firstName, lastName: $lastName, email: $email, phone: $phone, discipline: $discipline, createdOn: $createdOn, updatedOn: $updatedOn}';
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'first_name': firstName,
      'last_mame': lastName,
      'email': email,
      'phone': phone,
      'discipline': discipline,
      'created_on': createdOn,
      'updated_on': updatedOn,
    };
  }
}