class ApiEndpoints {
  // Endpoints
  // Auth
  static const String _authBase = 'auth';
  static const String login = '$_authBase/login';
  static const String signUp = '$_authBase/signup';

  // Server
  static const String _serverBase = 'server/';
  static const String createServer = '$_serverBase/create';
  static const String updateServer = '$_serverBase/update';
  static const String deleteServer = '$_serverBase/delete';
  static const String getServers = _serverBase;
}
