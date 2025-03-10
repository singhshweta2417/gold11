class CommonApiResponse {
  final String message;
  final String status;

  CommonApiResponse({required this.message, required this.status});

  factory CommonApiResponse.fromJson(Map<String, dynamic> json) {
    return CommonApiResponse(
      message: json['msg'] as String,
      status: json['status'] as String,
    );
  }
}