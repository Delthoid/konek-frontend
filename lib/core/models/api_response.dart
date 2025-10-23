class ApiResponse<T> {
  final String status;
  final String message;
  final String? error;
  final T? data;

  ApiResponse({
    required this.status,
    required this.message,
    this.error,
    this.data,
  });

  factory ApiResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) {
    return ApiResponse<T>(
      status: json['status'] as String,
      message: json['message'] as String,
      error: json['error'] as String?,
      data: json['data'] != null ? fromJsonT(json['data']) : null,
    );
  }
}
