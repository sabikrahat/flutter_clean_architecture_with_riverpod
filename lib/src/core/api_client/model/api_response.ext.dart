part of 'api_response.dart';

extension ApiResponseExt on ApiResponse {
  ApiResponse copyWith({
    bool? success,
    int? statusCode,
    String? message,
    int? page,
    int? limit,
    String? filter,
    dynamic data,
  }) {
    return ApiResponse()
      ..success = success ?? this.success
      ..statusCode = statusCode ?? this.statusCode
      ..message = message ?? this.message
      ..page = page ?? this.page
      ..limit = limit ?? this.limit
      ..filter = filter ?? this.filter
      ..data = data ?? this.data;
  }

  String toRawJson() => json.encode(toJson());

  Map<String, dynamic> toJson() => {
        _Json.success: success,
        _Json.statusCode: statusCode,
        _Json.message: message,
        _Json.page: page,
        _Json.limit: limit,
        _Json.filter: filter,
        _Json.data: data,
      };
}
