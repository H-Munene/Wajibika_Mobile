class ServerException implements Exception {
  ServerException({this.statusCode, required this.message});

  final String? statusCode;
  final String message;
}
