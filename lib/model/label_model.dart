class LabelModel {
  final int? id;
  final String name;

  LabelModel({this.id, required this.name});

  factory LabelModel.fromMap(Map<String, dynamic> json) => new LabelModel(
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
