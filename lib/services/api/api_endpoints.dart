import 'package:flutter/foundation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_disposable.dart';
import '../../core/constant/enums.dart';

class ApiEndPoints extends GetxService {
  ApiEndPoints() {
    setBaseUrl();
  }

  static String baseUrl = "https://dev-api.pocket-trainer.co/api/v1/";
  void setBaseUrl() {
      baseUrl = "https://dev-api.pocket-trainer.co/api/v1/";

    if (kDebugMode) {
      print("BaseUrl : $baseUrl");
    }
  }

  static const String login = "client/manage/auth/login";
  static const String forgotPassword = "client/manage/auth/send-email";
  static const String exerciseTags = "client/exercise/tags";
  static const String getExercise = "client/exercise/list";
  static const String createWorkout = "client/empty-workout/create";
  static const String createRoutine = "client/routine/create";
  static const String getWorkout = "client/empty-workout/list";
  static const String createExercise = "client/exercise/create";
  static const String uploadMedia = "client/common/upload-media";
  static const String deleteUploadMedia = "client/common/delete-media/";
  static const String getRoutineList = "client/routine/list";
  static const String getRoutineDetails = "client/routine/get-details?routineId=";
  static const String createFolder = "client/routine/create-folder";
  static const String listFolder = "client/routine/list-folder";
  static const String getRoutineCategory = "common/workout-types";
  static const String getRoutineCategoryDetail = "/client/workout/workout-by-id/";
  static const String exploreRoutineList = "client/workout/explore-routine-list";
  static const String updateRoutine = "client/routine/update";
  static const String deleteRoutine = "client/routine/delete/";
  static const String workoutConstant = "common/workout-constant";
  static const String trainerDetails = "client/common/trainer-details";
  static const String createRoutineByWorkout = "client/workout/create-routine-by-workout/";
  static const String exerciseMode = "common/exercise-mode";
  static const String performRoutine = "client/routine/performed/";
  static const String getExerciseDetails = "client/exercise/get-by-id/";
  static const String getChallengesList = "client/challenge/list";
  static const String getChallengeDetails = "client/challenge/details/";
  static const String updateChallengeMedia = "client/challenge-enrol/update-media/";
  static const String getHomeDetails = "client/common/home";
  static const String challengeEnrolAdd = "client/challenge-enrol/add";
  static const String getMyProgram = "client/main-program/list";
  static const String getProgramDetails = "client/main-program/get-details/";
  static const String profileDetail = "client/manage/auth/profile-details";
  static const String getMindsetList = "client/mindset/list";
  static const String editProfile = "client/manage/auth/edit-profile";
  static const String performProgram = "client/main-program-history/perform";
}
