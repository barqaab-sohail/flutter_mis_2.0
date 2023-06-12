class EmployeeModal {
  int? id;
  String? employeeNo;
  String? fullName;
  String? dateOfBirth;
  String? bloodGroup;
  String? dateOfJoining;
  String? cnic;
  String? age;
  String? designation;
  String? picture;
  String? mobile;
  String? status;

  EmployeeModal(
      {this.id,
      this.employeeNo,
      this.fullName,
      this.dateOfBirth,
      this.bloodGroup,
      this.dateOfJoining,
      this.cnic,
      this.age,
      this.designation,
      this.picture,
      this.mobile,
      this.status});

  EmployeeModal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    employeeNo = json['employee_no'];
    fullName = json['full_name'];
    dateOfBirth = json['date_of_birth'];
    bloodGroup = json['blood_group'];
    dateOfJoining = json['date_of_joining'];
    cnic = json['cnic'];
    age = json['age'];
    designation = json['designation'];
    picture = json['picture'];
    mobile = json['mobile'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['employee_no'] = this.employeeNo;
    data['full_name'] = this.fullName;
    data['date_of_birth'] = this.dateOfBirth;
    data['blood_group'] = this.bloodGroup;
    data['date_of_joining'] = this.dateOfJoining;
    data['cnic'] = this.cnic;
    data['age'] = this.age;
    data['designation'] = this.designation;
    data['picture'] = this.picture;
    data['mobile'] = this.mobile;
    data['status'] = this.status;
    return data;
  }
}
