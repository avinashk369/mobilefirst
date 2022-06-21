import 'package:parse_server_sdk/parse_server_sdk.dart';

import 'api_error.dart';

class ApiResponse {
  ApiResponse(this.success, this.statusCode, this.results, this.error)
      : count = results.length,
        result = results.isNotEmpty ? results.first : null;

  final bool success;
  final int statusCode;
  final List<dynamic> results;
  final dynamic result;
  int count;
  final ApiError error;
}

ApiResponse getApiResponse<T extends ParseObject>(ParseResponse response) {
  return ApiResponse(response.success, response.statusCode, response.results!,
      getApiError(response.error!)!);
}

ApiError? getApiError(ParseError response) {
  return ApiError(
      response.code, response.message, response.exception!, response.type!);
}
