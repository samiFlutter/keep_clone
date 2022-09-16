class SimpleModel {
  final int? id;
  final String name;
  final String? description;
  SimpleModel({this.id, required this.name, this.description});

  factory SimpleModel.fromMap(Map<String, dynamic> json) => new SimpleModel(
        id: json['id'],
        name: json['name'],
        description: json['description'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }
}
