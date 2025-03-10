class VerifyOtpModel {
  final String status;
  final String message;
  final dynamic data;

  VerifyOtpModel({
    required this.status,
    required this.message,
    required this.data,
  });

  factory VerifyOtpModel.fromJson(Map<String, dynamic> json) {
    return VerifyOtpModel(
      status: json['status']?.toString() ?? '0',
      message: json['msg'] ?? 'No message',
      data: json['data'],
    );
  }
}
