class RestfulConstant {
  RestfulConstant._();

  static const String API_VERSION = '/api/v1';

  static const String REMOTE_HOST = 'http://213.238.180.11';
  static const String LOCAL_HOST = 'http://localhost';
  static const String PORT = '3050';

  static const REMOTE_BASE_URL = REMOTE_HOST + ':' + PORT + API_VERSION;
  static const LOCAL_BASE_URL = LOCAL_HOST + ':' + PORT + API_VERSION;

  static const String AUTH = '/user';
  static const String CREATE_ACCOUNT = AUTH + '/create-an-account';
  static const String GET_ACCOUNT = AUTH + '/get-an-account';
  static const String GET_ACCOUNT_HASH = AUTH + '/get-an-account-hash';
}
