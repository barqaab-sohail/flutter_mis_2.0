class BaseAPI {
  static final String url = "http://192.168.1.10/";
  //"https://barqaab.pk/";
  //

  //"http://192.168.1.10/";
  //

  static final String baseURL = url + "hrms/public/api/";
  //"https://barqaab.pk/hrms/public/api/";
  //
  // "http://localhost/hrms/public/api/";
  //
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
  static final String projectLedgerActivity = 'misProjectLedgerActivity/';

  static final String assetList = 'assets';
}

class StoragePoint {
  static final String storage = BaseAPI.url + "hrms/storage/";
}
