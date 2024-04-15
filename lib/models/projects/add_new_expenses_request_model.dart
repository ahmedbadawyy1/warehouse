class AddNewExpenseRequestModel {
  final int projectId;
  final List<Expense> expenses;

  AddNewExpenseRequestModel({
    required this.projectId,
    required this.expenses,
  });

  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> expensesJsonList = expenses.map((expense) => expense.toJson()).toList();

    return {
      'project_id': projectId,
      'expenses': expensesJsonList,
    };
  }
}

class Expense {
  final String item;
  final double cost;
  final String date;
  final String engName;

  Expense({
    required this.item,
    required this.cost,
    required this.date,
    required this.engName,
  });

  Map<String, dynamic> toJson() {
    return {
      'item': item,
      'cost': cost,
      'date': date,
      'eng_name': engName,
    };
  }
}
