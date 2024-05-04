import '../../../../domain/entities/auth_entities/reset_code_response_entity.dart';

class ResetCodeResponseDto {
  String? status;

  ResetCodeResponseDto({this.status});

  ResetCodeResponseDto.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }

  ResetCodeResponseEntity toEntity() => ResetCodeResponseEntity(
        status: status,
      );
}
