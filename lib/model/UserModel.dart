class UserModal {
  int? status;
  String? userName;
  String? userDesignation;
  String? email;
  String? pictureUrl;
  String? token;
  List<String>? permissions;
  String? message;

  UserModal(
      {this.status,
      this.userName,
      this.userDesignation,
      this.email,
      this.pictureUrl,
      this.token,
      this.permissions,
      this.message});

  UserModal.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    userName = json['userName'];
    userDesignation = json['userDesignation'];
    email = json['email'];
    pictureUrl = json['pictureUrl'];
    token = json['token'];
    permissions = json['permissions'].cast<String>();
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['userName'] = this.userName;
    data['userDesignation'] = this.userDesignation;
    data['email'] = this.email;
    data['pictureUrl'] = this.pictureUrl;
    data['token'] = this.token;
    data['permissions'] = this.permissions;
    data['message'] = this.message;
    return data;
  }
}
