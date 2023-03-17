class ProjectDocumentModel {
  int? id;
  int? prFolderNameId;
  int? prDetailId;
  String? referenceNo;
  String? description;
  String? documentDate;
  String? fileName;
  String? extension;
  String? path;
  String? size;

  ProjectDocumentModel(
      {this.id,
      this.prFolderNameId,
      this.prDetailId,
      this.referenceNo,
      this.description,
      this.documentDate,
      this.fileName,
      this.extension,
      this.path,
      this.size});

  ProjectDocumentModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    prFolderNameId = json['pr_folder_name_id'];
    prDetailId = json['pr_detail_id'];
    referenceNo = json['reference_no'];
    description = json['description'];
    documentDate = json['document_date'];
    fileName = json['file_name'];
    extension = json['extension'];
    path = json['path'];
    size = json['size'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pr_folder_name_id'] = this.prFolderNameId;
    data['pr_detail_id'] = this.prDetailId;
    data['reference_no'] = this.referenceNo;
    data['description'] = this.description;
    data['document_date'] = this.documentDate;
    data['file_name'] = this.fileName;
    data['extension'] = this.extension;
    data['path'] = this.path;
    data['size'] = this.size;
    return data;
  }
}
