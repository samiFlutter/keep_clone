class SimpleModel {
  final int? id;
  final String name;
  SimpleModel({this.id, required this.name});

  factory SimpleModel.fromMap(Map<String, dynamic> json) => new SimpleModel(
        id: json['id'],
        name: json['name'],
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
    };
  }
}
