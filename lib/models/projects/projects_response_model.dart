class ProjectsResponseModel {
  int? id;
  String? nameOfProject;
  DateTime? date;
  String? engineerName;

  ProjectsResponseModel({this.id, this.nameOfProject, this.date, this.engineerName});

  factory ProjectsResponseModel.fromJson(Map<String, dynamic> json) {
    return ProjectsResponseModel(
      id: json['id'] as int?,
      nameOfProject: json['name_of_project'] as String?,
      date: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
      engineerName: json['eng_name'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name_of_project'] = nameOfProject;
    data['date'] = date?.toIso8601String();
    data['eng_name'] = engineerName;
    return data;
  }
}

// class ProjectsResponseModel {
//   int? id;
//   String? nameOfProject;
//   DateTime? date;
//   String? engineerName;
//
//   ProjectsResponseModel({this.id, this.nameOfProject, this.date, this.engineerName});
//
//   // Factory method to parse JSON data
//   factory ProjectsResponseModel.fromJson(Map<String, dynamic> json) {
//     return ProjectsResponseModel(
//       id: json['id'] as int?,
//       nameOfProject: json['name_of_project'] as String?,
//       date: json['date'] != null ? DateTime.parse(json['date'] as String) : null,
//       engineerName: json['eng_name'] as String?,
//     );
//   }
// }