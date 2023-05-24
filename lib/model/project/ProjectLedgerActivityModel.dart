class ProjectLedgerActivityModel {
  int? totalDebit;
  int? totalCredit;
  int? balance;
  int? projectCost;

  ProjectLedgerActivityModel(
      {this.totalDebit, this.totalCredit, this.balance, this.projectCost});

  ProjectLedgerActivityModel.fromJson(Map<String, dynamic> json) {
    totalDebit = json['total_debit'];
    totalCredit = json['total_credit'];
    balance = json['balance'];
    projectCost = json['projectCost'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total_debit'] = this.totalDebit;
    data['total_credit'] = this.totalCredit;
    data['balance'] = this.balance;
    data['projectCost'] = this.projectCost;
    return data;
  }
}
