class OtpResponse {
  final String otp;
  final String message;
  final String status;

  OtpResponse({required this.otp, required this.message, required this.status});

  factory OtpResponse.fromJson(Map<String, dynamic> json) {
    return OtpResponse(
      otp: json['otp'] as String,
      message: json['msg'] as String,
      status: json['status'] as String,
    );
  }
}