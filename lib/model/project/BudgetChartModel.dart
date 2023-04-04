
class BudgetChartModel {
  int? totalCost;
  int? pendingInvoices;
  int? totalInvoice;
  String? lastInvoice;
  double? budgetUtilization;
  double? remainingBudget;
  String? currentProgress;

  BudgetChartModel(
      {this.totalCost,
      this.pendingInvoices,
      this.totalInvoice,
      this.lastInvoice,
      double.parse(this.budgetUtilization),
      this.remainingBudget,
      this.currentProgress});

  BudgetChartModel.fromJson(Map<String, dynamic> json) {
    totalCost = json['total_cost'];
    pendingInvoices = json['pending_invoices'];
    totalInvoice = json['total_invoice'];
    lastInvoice = json['last_invoice'];
    budgetUtilization = json['budget_utilization'];
    remainingBudget = json['remaining_budget'];
    currentProgress = json['current_progress'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_cost'] = this.totalCost;
    data['pending_invoices'] = this.pendingInvoices;
    data['total_invoice'] = this.totalInvoice;
    data['last_invoice'] = this.lastInvoice;
    data['budget_utilization'] = this.budgetUtilization;
    data['remaining_budget'] = this.remainingBudget;
    data['current_progress'] = this.currentProgress;
    return data;
  }
}
