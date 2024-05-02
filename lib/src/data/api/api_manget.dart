// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:e_commerce/src/data/model/request/auth_request/forgot_pass_request.dart';
import 'package:e_commerce/src/data/model/request/auth_request/login_request.dart';
import 'package:e_commerce/src/data/model/request/auth_request/reset_pass_request.dart';
import 'package:e_commerce/src/data/model/request/auth_request/resset_code_request.dart';
import 'package:e_commerce/src/data/model/response/auth_response_dto/forgot_pass_response_dto.dart';
import 'package:e_commerce/src/data/model/response/auth_response_dto/login_response_dto.dart';
import 'package:e_commerce/src/data/model/response/auth_response_dto/reset_pass_response_dto.dart';
import 'package:e_commerce/src/data/model/response/auth_response_dto/resset_code_response_dto.dart';
import 'package:e_commerce/src/data/model/response/category_response_dto/categories_response_dto.dart';
import 'package:e_commerce/src/helper/failuers/failures.dart';

import '../../constant/api_const.dart';
import '../model/request/auth_request/register_request.dart';
import '../model/response/auth_response_dto/regsiter_response_dto.dart';
import 'package:http/http.dart' as http;

class ApiManger {
  ApiManger._();
  static ApiManger? _instance;
  static ApiManger get instance {
    _instance ??= ApiManger._();
    return _instance!;
  }

  //! function register
  Future<Either<Failure, RegisterResponseDto>> register(
      RegisterRequest registerRequest) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      //? connected inter net
      Uri url = Uri.https(apiBaseUrl, apiRegister);
      var response = await http.post(url, body: registerRequest.toJson());
      var registerResponse =
          RegisterResponseDto.fromJson(jsonDecode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        //? success get data
        return Right(registerResponse);
      } else if (response.statusCode == 400 &&
          registerResponse.errors != null) {
        //? have error in response such invalid number or email or password or rePassword
        return Left(Failure(errorMessage: registerResponse.errors?.msg));
      } else {
        //? account already exists
        return Left(Failure(
            errorMessage:
                registerResponse.message ?? "Account Already Exists"));
      }
    } else {
      return Left(Failure(errorMessage: 'No Internet Connection'));
    }
  }

  //! function login

  Future<Either<Failure, LoginResponseDto>> login(
      {required LoginRequest loginRequest}) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      //? connected inter net
      Uri url = Uri.https(apiBaseUrl, apiLogin);
      var response = await http.post(url, body: loginRequest.toJson());
      var loginResponse = LoginResponseDto.fromJson(jsonDecode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        //? success get data
        return Right(loginResponse);
      } else if (response.statusCode == 400 && loginResponse.errors != null) {
        //? have error in response such invalid   email or password
        return Left(Failure(errorMessage: loginResponse.errors?.msg));
      } else {
        //? Incorrect email or password
        return Left(Failure(errorMessage: loginResponse.message));
      }
    } else {
      return Left(Failure(errorMessage: 'No Internet Connection'));
    }
  }

  //! function for get password
  Future<Either<Failure, ForgotPasswordResponseDto>> forgotPassword(
      {required ForgotPasswordRequest forgotPasswordRequest}) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      //? connected inter net
      Uri url = Uri.https(apiBaseUrl, apiForgotPassword);
      var response = await http.post(url, body: forgotPasswordRequest.toJson());
      var forgotPasswordResponse =
          ForgotPasswordResponseDto.fromJson(jsonDecode(response.body));
      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          forgotPasswordResponse.statusMsg == "success") {
        //? success get data
        return Right(forgotPasswordResponse);
      } else if (response.statusCode == 400 &&
          forgotPasswordResponse.statusMsg == "fail") {
        //? have error in response such invalid   email or password
        return Left(Failure(errorMessage: forgotPasswordResponse.message));
      } else {
        //? Incorrect email or password
        return Left(Failure(errorMessage: forgotPasswordResponse.message));
      }
    } else {
      return Left(Failure(errorMessage: 'No Internet Connection'));
    }
  }

  //! function Reset code
  Future<Either<Failure, ResetCodeResponseDto>> resetCode(
      {required ResetCodeRequest resetCodeRequest}) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      Uri url = Uri.https(apiBaseUrl, apiResetCode);
      var response = await http.post(url, body: resetCodeRequest.toJson());
      var resetCodeResponse =
          ResetCodeResponseDto.fromJson(jsonDecode(response.body));
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return Right(resetCodeResponse);
      } else if (response.statusCode == 400) {
        return Left(Failure(errorMessage: "Invalid Code"));
      } else {
        return Left(Failure(errorMessage: 'Error in response'));
      }
    } else {
      return Left(Failure(errorMessage: 'No Internet Connection'));
    }
  }

  //! function reset password
  Future<Either<Failure, ResetPasswordResponseDto>> resetPassword(
      {required ResetPasswordRequest resetPasswordRequest}) async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());
    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      Uri url = Uri.https(apiBaseUrl, apiResetPassword);
      var response = await http.put(url, body: resetPasswordRequest.toJson());
      var resetPasswordResponse =
          ResetPasswordResponseDto.fromJson(jsonDecode(response.body));
      if (response.statusCode >= 200 &&
          response.statusCode < 300 &&
          resetPasswordResponse.token != null) {
        return Right(resetPasswordResponse);
      } else if (response.statusCode == 400 &&
          resetPasswordResponse.statusMsg == "fail") {
        return Left(Failure(errorMessage: "reset code not verified"));
      } else {
        return Left(Failure(errorMessage: 'Error in response'));
      }
    } else {
      return Left(Failure(errorMessage: 'No Internet Connection'));
    }
  }
  //! function getAllCategories

  Future<Either<Failure, CategoryResponseDto>> getAllCategory() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      //? connected internet
      Uri url = Uri.https(apiBaseUrl, apiGetAllCategory);
      var response = await http.get(url);

      var getAllCategoryResponse =
          CategoryResponseDto.fromJson(jsonDecode(response.body));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        //? success get data
        return Right(getAllCategoryResponse);
      } else {
        //? Incorrect
        return Left(Failure(errorMessage: 'Error in response'));
      }
    } else {
      return Left(Failure(errorMessage: 'No Internet Connection'));
    }
  }
}
