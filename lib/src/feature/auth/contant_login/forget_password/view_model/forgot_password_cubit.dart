import 'package:bloc/bloc.dart';
import '../../../../../data/model/request/auth_request/forgot_pass_request.dart';
import '../../../../../domain/entities/auth_entities/fotgot_pass_response_entity.dart';
import '../../../../../domain/usecases/auth_usecases/forgot_pass_usecase.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

part 'forgot_password_state.dart';

class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit({required this.forgotPasswordUseCases})
      : super(ForgotPasswordInitial());
  var emailController = TextEditingController();
  GlobalKey<FormState> fromState = GlobalKey();
  ForgotPasswordUseCase forgotPasswordUseCases;
  void forgotPassword() async {
    if (fromState.currentState!.validate()) {
      emit(ForgotPasswordLoading(message: "Loading..."));
      var either = await forgotPasswordUseCases.invoke(
          forgotPassRequest: ForgotPasswordRequest(
        email: emailController.text,
      ));
      return either.fold((l) {
        emit(ForgotPasswordError(errorMessage: l.errorMessage));
      }, (response) {
        emit(ForgotPasswordSuccess(forgotPasswordResponseEntity: response));
      });
    }
  }
}
