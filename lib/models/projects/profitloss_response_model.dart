class ProfitLossResponseModel {
  final int projectId;
  final int totalRevenue;
  final int totalExpenses;
  final int profitLoss;

  ProfitLossResponseModel({
    required this.projectId,
    required this.totalRevenue,
    required this.totalExpenses,
    required this.profitLoss,
  });

  factory ProfitLossResponseModel.fromJson(Map<String, dynamic> json) {
    return ProfitLossResponseModel(
      projectId: int.parse(json['projectId'].toString()),
      totalRevenue: json['totalRevenue'] ?? 0,
      totalExpenses: json['totalExpenses'] ?? 0,
      profitLoss: json['profitLoss'] ?? 0,
    );
  }
}
