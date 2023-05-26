class ProjectLedgerActivityModel {
  int? totalDebit;
  int? totalCredit;
  int? balance;
  int? projectCost;
  String? lastUpdate;

  ProjectLedgerActivityModel(
      {this.totalDebit,
      this.totalCredit,
      this.balance,
      this.projectCost,
      this.lastUpdate});

  ProjectLedgerActivityModel.fromJson(Map<String, dynamic> json) {
    totalDebit = json['total_debit'];
    totalCredit = json['total_credit'];
    balance = json['balance'];
    projectCost = json['projectCost'];
    lastUpdate = json['last_update'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_debit'] = this.totalDebit;
    data['total_credit'] = this.totalCredit;
    data['balance'] = this.balance;
    data['projectCost'] = this.projectCost;
    data['last_update'] = this.lastUpdate;
    return data;
  }
}
