class BaseAPI {
  static final String baseURL = "http://192.168.1.10/hrms/public/api/";
  // "https://barqaab.pk/hrms/public/api/";
  //"http://localhost/hrms/public/api/";
}
//

class EndPoints {
  static final String login = 'mis/login';
  static final String logout = 'mis/logout';
  static final String employeeList = 'employees';
  static final String employeeDocuments = 'employeeDocuments/';
  static final String projectDocuments = 'projectDocuments/';
  static final String projectList = 'powerRunningProjectsTable';
  static final String allProjectDocuments = 'allProjectDocuments';
  static final String proejctSummaryMM = 'proejctSummaryMM/';

  static final String assetList = 'assets';
}

class StoragePoint {
  static final String storage = "https://hrms.barqaab.pk/storage/";
}
