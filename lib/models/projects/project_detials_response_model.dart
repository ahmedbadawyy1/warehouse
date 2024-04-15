class ProjectDetailsResponseModel {
  List<Project> projectDetails;

  ProjectDetailsResponseModel({required this.projectDetails});

  factory ProjectDetailsResponseModel.fromJson(Map<String, dynamic> json) {
    var projectDetailsList = json['projectDetails'] as List;
    List<Project> projects =
    projectDetailsList.map((e) => Project.fromJson(e)).toList();

    return ProjectDetailsResponseModel(projectDetails: projects);
  }
}

class Project {
  int projectId;
  DateTime date;
  String place;
  String company;
  int total;
  String engName;
  List<Expense> expenses;

  Project({
    required this.projectId,
    required this.date,
    required this.place,
    required this.company,
    required this.total,
    required this.engName,
    required this.expenses,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    var expensesList = json['expenses'] as List;
    List<Expense> expenseDetails =
    expensesList.map((e) => Expense.fromJson(e)).toList();

    return Project(
      projectId: json['project_id'],
      date: DateTime.parse(json['date']),
      place: json['place'],
      company: json['company'],
      total: json['total'],
      engName: json['eng_name'],
      expenses: expenseDetails,
    );
  }
}

class Expense {
  String item;
  int cost;
  DateTime expenseDate;
  String expenseEngName;

  Expense({
    required this.item,
    required this.cost,
    required this.expenseDate,
    required this.expenseEngName,
  });

  factory Expense.fromJson(Map<String, dynamic> json) {
    return Expense(
      item: json['item'],
      cost: json['cost'],
      expenseDate: DateTime.parse(json['expense_date']),
      expenseEngName: json['expense_eng_name'],
    );
  }
}

