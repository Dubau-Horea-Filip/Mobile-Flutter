// ignore_for_file: non_constant_identifier_names, file_names

class Pet {
  final int? id;
  final String name = "";
  final int? age = 0;
  final String species = "";
  final String behaviour = "";
  final String medical_records = "";

  const Pet(
      {required age,
      required behaviour,
      required name,
      required medical_records,
      required species,
      this.id});
  factory Pet.fromJson(Map<String, dynamic> json) => Pet(
      id: json['id'],
      name: json['name'],
      age: json['age'],
      species: json['species'],
      behaviour: json['behaviour'],
      medical_records: json['medical_records']);

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'age': age,
        'species': species,
        'behaviour': behaviour,
        'medical_records': medical_records
      };
}
