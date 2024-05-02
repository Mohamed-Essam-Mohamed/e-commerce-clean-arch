class ResetPasswordResponseDto {
  String? token;
  String? statusMsg;
  String? message;

  ResetPasswordResponseDto({this.token, this.message, this.statusMsg});

  ResetPasswordResponseDto.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    statusMsg = json['statusMsg'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['statusMsg'] = this.statusMsg;
    data['message'] = this.message;
    return data;
  }
}