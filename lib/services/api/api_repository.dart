import 'dart:developer';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import '../../core/utils/common/app_loader.dart';
import '../../core/utils/common/console.dart';
import 'api_client.dart';
import 'api_endpoints.dart';
import 'api_validation.dart';
import 'model/api_response_model.dart';

class ApiRepository extends GetxService {
  static final ApiClient _apiClient = ApiClient();

  static String getBaseUrl(String endPoint) => ApiEndPoints.baseUrl + endPoint;

  ///////////////////////////////// ======== GET ========  /////////////////////////////////

  // static Future<List<ExerciseTagModel>?> exerciseTagsApi() async {
  //   AppLoader.showLoader();
  //   return await _apiClient.get(url: getBaseUrl(ApiEndPoints.exerciseTags)).then(
  //     (ApiResponseModel response) async {
  //       if (await ApiValidation.validateResponse(response) ?? false) {
  //         AppLoader.removeLoader();
  //         return (response.responseData as List<dynamic>).map((item) => ExerciseTagModel.fromMap(item as Map<String, dynamic>)).toList();
  //       } else {
  //         return null;
  //       }
  //     },
  //   ).catchError((err) => catchErr(err));
  // }
  //
  // static Future<RoutineDetailsResponse?> getRoutineDetails(String routineId) async {
  //   AppLoader.showLoader();
  //   return await _apiClient.get(url: getBaseUrl("${ApiEndPoints.getRoutineDetails}$routineId")).then(
  //     (ApiResponseModel response) async {
  //       if (await ApiValidation.validateResponse(response) ?? false) {
  //         AppLoader.removeLoader();
  //         return RoutineDetailsResponse.fromMap(response.responseData);
  //       } else {
  //         return null;
  //       }
  //     },
  //   ).catchError((err) => catchErr(err));
  // }


  ///////////////////////////////// ======== POST ========  /////////////////////////////////

  // static Future<LoginResponse?> loginApi(Map<String, dynamic> map) async {
  //   AppLoader.showLoader();
  //   return await _apiClient.post(url: getBaseUrl(ApiEndPoints.login), body: map).then(
  //     (ApiResponseModel response) async {
  //       if (await ApiValidation.validateResponse(response) ?? false) {
  //         AppLoader.removeLoader();
  //         return LoginResponse.fromMap(response.responseData);
  //       } else {
  //         return null;
  //       }
  //     },
  //   ).catchError((err) => catchErr(err));
  // }
  //
  // static Future<String?> forgotPasswordApi(Map<String, dynamic> map) async {
  //   AppLoader.showLoader();
  //   return await _apiClient.post(url: getBaseUrl(ApiEndPoints.forgotPassword), body: map).then(
  //     (ApiResponseModel response) async {
  //       if (await ApiValidation.validateResponse(response) ?? false) {
  //         AppLoader.removeLoader();
  //         return response.messageText;
  //       } else {
  //         return response.messageText;
  //       }
  //     },
  //   ).catchError((err) => catchErr(err));
  // }
  //
  // static Future<ApiResponseModel?> createWorkoutApi(CreateWorkoutPayload payload) async {
  //   AppLoader.showLoader();
  //   return await _apiClient.post(url: getBaseUrl(ApiEndPoints.createWorkout), body: payload.toMap()).then(
  //     (ApiResponseModel response) async {
  //       if (await ApiValidation.validateResponse(response) ?? false) {
  //         AppLoader.removeLoader();
  //         return ApiResponseModel(
  //           statusCode: response.statusCode,
  //           messageText: response.messageText,
  //         );
  //       }
  //     },
  //   ).catchError((err) => catchErr(err));
  // }



  static catchErr(Exception err, [isShowLoader = true]) {
    if (isShowLoader) AppLoader.removeLoader();
    ApiValidation.showDialogueAccordingResponse(err.toString());
    Console.debug(err);
    return null;
  }
}
