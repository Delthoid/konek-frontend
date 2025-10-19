class RouteNames {
  static const String home = '/';
  static const String auth = '/auth';
  static const String profile = '/profile';
  static const String settings = '/settings';

  // Auth
  static const String login = '$auth/login';
  static const String signUp = '$auth/sign-up';

  // Servers
  static const String server = '$home/server/:serverId';
  static const String channel = '$server/channel/:channelId';
}