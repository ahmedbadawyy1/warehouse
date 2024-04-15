class AddNewProjectRequestModel {
  String nameOfProject;
  String date;
  String engName;
  String place;
  String company;
  int total;

  AddNewProjectRequestModel({
    required this.nameOfProject,
    required this.date,
    required this.engName,
    required this.place,
    required this.company,
    required this.total,
  });

  factory AddNewProjectRequestModel.fromJson(Map<String, dynamic> json) {
    return AddNewProjectRequestModel(
      nameOfProject: json['name_of_project'],
      date: json['date'],
      engName: json['eng_name'],
      place: json['place'],
      company: json['company'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {
      'name_of_project': nameOfProject,
      'date': date,
      'eng_name': engName,
      'place': place,
      'company': company,
      'total': total,
    };
    return data;
  }
}
